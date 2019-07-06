import 'package:quickexpression/quickexpression.dart' as quickexpression;
import 'package:petitparser/petitparser.dart';
import 'package:quickexpression/tokenizer.dart';

import 'grammer.dart';

main(List<String> arguments) {
  Tokenizer tokenizer = Tokenizer();
  print(tokenizer.tokenizeStrings2("a + \"cc\" + (f('aa\"bb\"')[2*3+i] + 'bb') + sdsdf"));
  print(tokenizer.tokenizeParentheses("a + (f(2"));
  print(tokenizer.tokenizeBrackets("a + (f('aa')[2*3+i] + 'bb') + sdsdf"));
  print(tokenizer.tokenizeOperators("a+v2*c+d- e2"));

  num.parse('-2');

//  var tokens = tokenizer.tokenize("a + \"cc\" + (f('a\"a\"',a==c)[2*3+i+\"2\"].getCustomer().name + 'bb') + 'sdsdf'");
  var tokens = tokenizer.tokenize("a+b-(c(2+3*g(a+f, null).p[d+e/(2*f-1)])+d)*((e*f)+(g)*(h/(a +c)))");
  //var tokens = tokenizer.tokenize("a+b-(c(2+3)*5)");
  print(tokens);
}
