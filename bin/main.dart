import 'package:quickexpression/quickexpression.dart' as quickexpression;
import 'package:petitparser/petitparser.dart';
import 'package:quickexpression/tokenizer.dart';

import 'grammer.dart';

abstract class Expression{

}


class Literal extends Expression {
  String content;

  Literal(this.content);

}

class ExpressionParser{
  DartGrammarDefinition dartGrammar = DartGrammarDefinition();

  ExpressionParser() {

  }

  Parser<String> get escapedChar => (char(r"\")&anyOf("nrtbfv\"'")).pick(1);

  String unescape(String v) => v.replaceAllMapped(new RegExp("\\\\[nrtbf\"']"),
          (v)=>const {"n":"\n","r":"\r","t":"\t","b":"\b","f":"\f","v":"\v",
        '"': '"', "'": "'"}[v.group(0).substring(1)]);

  Parser<Literal> literal() {
    return (char("'")&(anyOf(r"'\").neg()|escapedChar).star().flatten()&char("'")).pick(1)
        .map((v)=>new Literal("'$v'"));
  }

  Parser<Expression> expression() => dartGrammar.expression().cast();
}

main(List<String> arguments) {
  Tokenizer tokenizer = Tokenizer();
  print(tokenizer.tokenizeStrings("a + (f('aa')[2*3+i] + 'bb') + sdsdf"));
  print(tokenizer.tokenizeParentheses("a + (f(2"));
  print(tokenizer.tokenizeBrackets("a + (f('aa')[2*3+i] + 'bb') + sdsdf"));
  print(tokenizer.tokenizeOperators("a+v2*c+d- e2"));

  var tokens = tokenizer.tokenize("a + (f('aa',a==c)[2*3+i].getCustomer().name + 'bb') + 'sdsdf'");
  print(tokens);
}
