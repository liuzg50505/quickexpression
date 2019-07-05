int calculate() {
  return 6 * 7;
}

const Map<String,int> binaryOperations = const {
  '||': 1, '&&': 2, '|': 3,  '^': 4,  '&': 5,
  '==': 6, '!=': 6,
  '<=': 7,  '>=': 7, '<': 7,  '>': 7,
  '<<':8,  '>>': 8,
  '+': 9, '-': 9,
  '*': 10, '/': 10, '%': 10
};


class Identifier {
  final String name;

  Identifier(this.name) {
    assert(name!=null);
    assert(name != "null");
    assert(name != "false");
    assert(name != "true");
    assert(name != "this");
  }

  @override
  String toString() => name;
}

abstract class Expression {
  String toTokenString();
}

abstract class SimpleExpression implements Expression {

  @override
  String toTokenString() => toString();
}

abstract class CompoundExpression implements Expression {

  @override
  String toTokenString() => "($this)";
}

class Literal extends SimpleExpression {

  final dynamic value;
  final String raw;

  Literal(this.value, [String raw]) : raw = raw ?? (value is String ? '"$value"' /*TODO escape*/ : "$value");

  @override
  String toString() => raw;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator==(dynamic other) => other is Literal && other.value==value;

}

class Variable extends SimpleExpression {
  final Identifier identifier;

  Variable(this.identifier);

  @override
  String toString() => "$identifier";
}

class ThisExpression extends SimpleExpression {


}

class MemberExpression extends SimpleExpression {

  final Expression object;

  final Identifier property;

  MemberExpression(this.object, this.property);

  @override
  String toString() => "${object.toTokenString()}.$property";
}

class IndexExpression extends SimpleExpression {

  final Expression object;

  final Expression index;

  IndexExpression(this.object, this.index);

  @override
  String toString() => "${object.toTokenString()}[$index]";
}

class CallExpression extends SimpleExpression {
  final Expression callee;
  final List<Expression> arguments;

  CallExpression(this.callee, this.arguments);

  @override
  String toString() => "${callee.toTokenString()}(${arguments.join(", ")})";
}

class UnaryExpression extends SimpleExpression {
  final String operator;

  final Expression argument;

  final bool prefix;

  UnaryExpression(this.operator, this.argument, {this.prefix: true});

  @override
  String toString() => "$operator$argument";
}

class BinaryExpression extends CompoundExpression {

  final String operator;
  final Expression left;
  final Expression right;

  BinaryExpression(this.operator, this.left, this.right);

  static int precedenceForOperator(String operator) =>
      binaryOperations[operator];

  int get precedence => precedenceForOperator(operator);

  @override
  String toString() {
    var l = (left is BinaryExpression&&(left as BinaryExpression).precedence<precedence) ? "($left)" : "$left";
    var r = (right is BinaryExpression&&(right as BinaryExpression).precedence<precedence) ? "($right)" : "$right";
    return "$l$operator$r";
  }

  @override
  int get hashCode => left.hashCode + operator.hashCode+right.hashCode;

  @override
  bool operator==(dynamic other) => other is BinaryExpression&&
      other.left==left&&other.operator==operator&&other.right==right;

}

class ConditionalExpression extends CompoundExpression {
  final BinaryExpression test;
  final Expression consequent;
  final Expression alternate;

  ConditionalExpression(this.test, this.consequent, this.alternate);


  @override
  String toString() => "$test ? $consequent : $alternate";
}

