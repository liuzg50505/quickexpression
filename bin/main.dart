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

  printASTTree("a+b-(c(2+3*g(a+f, null).p[d+e/(2*f-1)])+d)*((e*f)+(g)*(h/(a +c)))",3);
  printASTTree("a + \"cc\" + (f('a\"a\"',a==c)[2*3+i+\"2\"].getCustomer().name + 'bb') + 'sdsdf'",3);
}
