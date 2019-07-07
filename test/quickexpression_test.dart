import 'package:quickexpression/expression.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    MapEvaluationContext context = MapEvaluationContext({
      "a": 2,
      "b": 3,
      "c": 4,
      "d": {
        "e":{
          "f": (t)=>3+t
        },
        "add": (a, b)=> a+b
      }
    });

    String expstr = "a+b*(c+2*3-d.e.f(1)+(6/(3+d.add(2,1))))/a+b";
    ExpressionParser parser = new ExpressionParser(null);
    var expression = parser.parseExpressionText(expstr);
    var r = expression.evaluate(context);
    print(r);

  });
}
