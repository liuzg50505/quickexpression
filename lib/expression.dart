import 'dart:html';

import 'tokenizer.dart';

class EvalutaionException implements Exception{

  String message;
  EvalutaionException([this.message]);

  @override
  String toString() {
    return 'EvalutaionException{message: $message}';
  }
}

abstract class EvaluationContext {
  Object get(String name);
  void set(String name, Object value);
}

abstract class QuickExpression {
  Object evaluate(EvaluationContext context);

  String toCodeString();
}

class LiteralExpression extends QuickExpression {
  LiteralToken literalToken;

  LiteralExpression(this.literalToken);

  @override
  Object evaluate(EvaluationContext context) {
    if(literalToken is StringToken) {
      return literalToken.toCodeString().substring(1, literalToken.toCodeString().length-1);
    }else if(literalToken is NumberToken) {
      return num.parse(literalToken.toCodeString());
    }else if(literalToken is BoolToken) {
      return literalToken.toCodeString()=="true";
    }else if(literalToken is NullToken) {
      return null;
    }
    throw new EvalutaionException("Error literal type! ${literalToken}");
  }

  @override
  String toCodeString() {
    return literalToken.toCodeString();
  }

}

class SequenceBinaryExpression extends QuickExpression{
  List<Token> tokens;

  SequenceBinaryExpression() {
    tokens = List();
  }

  @override
  Object evaluate(EvaluationContext context) {
    // TODO: implement evaluate
    return null;
  }

  @override
  String toCodeString() {
    return tokens.map((t)=>t.toCodeString()).join('');
  }


}

