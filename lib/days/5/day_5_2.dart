import 'package:advent_of_coding/file_reader.dart';

// While the Elves get to work printing the correctly-ordered updates, you have a little time to fix the rest of them.

// For each of the incorrectly-ordered updates, use the page ordering rules to put the page numbers in the right order. For the above example, here are the three incorrectly-ordered updates and their correct orderings:

// 75,97,47,61,53 becomes 97,75,47,61,53.
// 61,13,29 becomes 61,29,13.
// 97,13,75,29,47 becomes 97,75,47,29,13.
// After taking only the incorrectly-ordered updates and ordering them correctly, their middle page numbers are 47, 29, and 47. Adding these together produces 123.

// Find the updates which are not in the correct order. What do you get if you add up the middle page numbers after correctly ordering just those updates?
void main() {
  var listOfString = readFile('lib/days/5/day_5_2.txt');
  var rule = <String>[];
  var orderint = <String>[];
  int sum = 0;
  var a = listOfString.firstWhere((element) => element.isEmpty);
  rule = listOfString.sublist(0, listOfString.indexOf(a));
  var ruleString = rule.join('safal');
  orderint = listOfString.sublist(listOfString.indexOf(a) + 1);
  for (var i = 0; i < orderint.length; i++) {
    var newTempList = orderint[i].split(',');
    for (var j = 0; j < newTempList.length - 1; j++) {
      var valueToCheck = "${newTempList[j]}|${newTempList[j + 1]}";
      if (!ruleString.contains(valueToCheck)) {
        var toAdd =fixAndReturnMiddlePart(newTempList, ruleString);
        sum += toAdd;
        break;
      }
    }
  }
  print(sum);
}

int fixAndReturnMiddlePart(List<String> orderint, String ruleString) {
  var c = [...orderint];
  c.sort((a, b) {
    var valueToCheck = "$a|$b";
    var f = ruleString.contains(valueToCheck) ? -1 : 1;
    return f;
  });

  var midIndex = (c.length / 2).floor();
  return int.parse(c[midIndex]);
}
