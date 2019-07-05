
const Map<String,int> binaryOperations = const {
  '||': 1, '&&': 2, '|': 3,  '^': 4,  '&': 5,
  '==': 6, '!=': 6,
  '<=': 7,  '>=': 7, '<': 7,  '>': 7,
  '+': 9, '-': 9,
  '*': 10, '/': 10, '%': 10
};


abstract class Token {
  String code;

  Token(this.code);

  @override
  String toString() {
    return this.code;
  }


}

class OperatorToken extends Token {
  OperatorToken(String code) : super(code);
}

class CommaToken extends Token {
  CommaToken(String code) : super(code);
}

class DotToken extends Token {
  DotToken(String code) : super(code);
}

class LiteralToken extends Token {
  LiteralToken(String code) : super(code);
}

class QuoteStartToken extends Token {
  QuoteStartToken(String code) : super(code);
}

class QuoteEndToken extends Token {
  QuoteEndToken(String code) : super(code);
}

class ExpressionToken extends Token {
  ExpressionToken(String code) : super(code);
}

class UnTokenizedToken extends Token {
  UnTokenizedToken(String code) : super(code);
}

class Tokenizer {

  List<int> strIdxlist(String str, String substr) {
    List<int> r = List();
    int idx = str.indexOf(substr);
    while(idx>=0) {
      r.add(idx);
      idx = str.indexOf(substr, idx+substr.length);
    }
    return r;
  }

  List<Token> tokenizeStrings(String code) {
    List<Token> tokens = List();
    int pos = 0;
    bool instringtoken = false;
    for (int i = 0; i < code.length; i++) {
      var c = code.substring(i, i + 1);
      if (c == "'"||i==code.length-1) {
        if (instringtoken) {
          tokens.add(LiteralToken(code.substring(pos, i + 1)));
          instringtoken = false;
          pos = i + 1;
        } else {
          if(i==code.length-1) i = code.length;
          tokens.add(UnTokenizedToken(code.substring(pos, i)));
          instringtoken = true;
          pos = i;
        }
      }
    }
    return tokens;
  }

  List<Token> tokenizeParentheses(String code) {
    List<Token> tokens = List();
    int pos = 0;
    for (int i = 0; i < code.length; i++) {
      var c = code.substring(i, i + 1);
      if (c == '(') {
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(QuoteStartToken('('));
        pos = i+1;
      }else if(c==')'){
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(QuoteStartToken(')'));
        pos = i+1;
      }else if(i==code.length-1) {
        tokens.add(UnTokenizedToken(code.substring(pos)));
      }
    }
    return tokens;
  }

  List<Token> tokenizeComma(String code) {
    List<Token> tokens = List();
    int pos = 0;
    for (int i = 0; i < code.length; i++) {
      var c = code.substring(i, i + 1);
      if (c == ',') {
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(CommaToken(','));
        pos = i+1;
      }else if(i==code.length-1) {
        tokens.add(UnTokenizedToken(code.substring(pos)));
      }
    }
    return tokens;
  }

  List<Token> tokenizeDot(String code) {
    List<Token> tokens = List();
    int pos = 0;
    for (int i = 0; i < code.length; i++) {
      var c = code.substring(i, i + 1);
      if (c == '.') {
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(DotToken('.'));
        pos = i+1;
      }else if(i==code.length-1) {
        tokens.add(UnTokenizedToken(code.substring(pos)));
      }
    }
    return tokens;
  }

  List<Token> tokenizeBrackets(String code) {
    List<Token> tokens = List();
    int pos = 0;
    for (int i = 0; i < code.length; i++) {
      var c = code.substring(i, i + 1);
      if (c == '[') {
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(QuoteStartToken('['));
        pos = i+1;
      }else if(c==']'){
        tokens.add(UnTokenizedToken(code.substring(pos, i)));
        tokens.add(QuoteStartToken(']'));
        pos = i+1;
      }else if(i==code.length-1) {
        tokens.add(UnTokenizedToken(code.substring(pos)));
      }
    }
    return tokens;
  }

  List<Token> tokenizeOperators(String code) {
    var operators = binaryOperations.keys.toList();
    Map<int, String> operatormap = {};
    for(String op in operators) {
       var idxlist = strIdxlist(code, op);
       for (int idx in idxlist) {
         operatormap[idx] = op;
       }
    }
    var idxlist = operatormap.keys.toList();
    idxlist.sort();
    int pos = 0;
    List<Token> tokens = List();
    for (int idx in idxlist) {
      String op = operatormap[idx];
      int len = op.length;
      tokens.add(UnTokenizedToken(code.substring(pos, idx)));
      tokens.add(OperatorToken(op));
      pos = idx+len;
      if(idx==idxlist.last) {
        tokens.add(UnTokenizedToken(code.substring(pos)));
      }
    }
    if(tokens.isEmpty) return [UnTokenizedToken(code)];
    return tokens;
  }

  List<Token> performSubTokenize(List<Token> tokens, Function tokenfunc) {
    List<Token> r = List();
    for(Token token in tokens) {
      if(token is UnTokenizedToken) {
        var subtokens = tokenfunc(token.code);
        r.addAll(subtokens);
      }else{
        r.add(token);
      }
    }
    return r;
  }

  tokenize(String code) {
    List<Token> tokens = tokenizeStrings(code);
    tokens = performSubTokenize(tokens, tokenizeParentheses);
    tokens = performSubTokenize(tokens, tokenizeBrackets);
    tokens = performSubTokenize(tokens, tokenizeOperators);
    tokens = performSubTokenize(tokens, tokenizeComma);
    tokens = performSubTokenize(tokens, tokenizeDot);
    tokens = tokens.where((token) {
      if(token is UnTokenizedToken) {
        return token.code.trim().isNotEmpty;
      }
      return true;
    }).toList();
    return tokens;
  }
}
