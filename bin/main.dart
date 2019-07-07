
import 'package:quickexpression/expression.dart';
import 'package:quickexpression/quickexpression.dart' as quickexpression;
import 'package:petitparser/petitparser.dart';
import 'package:quickexpression/tokenizer.dart';

import 'grammer.dart';

main(List<String> arguments) {
//  Tokenizer tokenizer = Tokenizer();
//  var tokens = tokenizer.tokenize("a + \"cc\" + (f('a\"a\"',a==c)[2*3+i+\"2\"].getCustomer().name + 'bb') + 'sdsdf'");
//  var tokens = tokenizer.tokenize("a+b-(c(2+3*g(a+f, null).p[d+e/(2*f-1)])+d)*((e*f)+(g)*(h/(a +c)))")
//  var tokens = tokenizer.tokenize("a+b-(c(2+3)*5)");
//  print(tokens);

//  printASTTree("a+b-(c(2+3*g(a+f, null).p[d+e/(2*f-1)])+d)*((e*f)+(g)*(h/(a +c)))/4",3);
//  printASTTree("a + \"cc\" + (f('a\"a\"',a==c)[2*3+i+\"2\"].getCustomer().name + 'bb') + 'sdsdf'",3);

  MapEvaluationContext context = MapEvaluationContext({
    "a": 2,
    "b": 3,
    "c": 4,
    "d": {
      "e":{
        "f": ()=>3
      }
    }
  });



  String expstr = "a+b*(c+2*3-d.e.f()+(6/3))/a+b";
  ExpressionParser parser = new ExpressionParser(null);
  var expression = parser.parseExpressionText(expstr);
  var r = expression.evaluate(context);
  print(r);

}
