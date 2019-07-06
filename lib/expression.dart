import 'tokenizer.dart';

abstract class QuickExpression {
  Object evaluate() {

  }
}

class LiteralExpression {
  Token literalToken;

  LiteralExpression(this.literalToken);

}

class BinaryExpression {
  Token leftpart;
  Token rightpart;
  OperatorToken operator;

  BinaryExpression(this.leftpart, this.rightpart, this.operator);

}

