import 'dart:math';

import 'package:advent_of_coding/file_reader.dart';


// The engineers seem concerned; the total calibration result you gave them is nowhere close to being within safety tolerances. Just then, you spot your mistake: some well-hidden elephants are holding a third type of operator.

// The concatenation operator (||) combines the digits from its left and right inputs into a single number. For example, 12 || 345 would become 12345. All operators are still evaluated left-to-right.

// Now, apart from the three equations that could be made true using only addition and multiplication, the above example has three more equations that can be made true by inserting operators:

// 156: 15 6 can be made true through a single concatenation: 15 || 6 = 156.
// 7290: 6 8 6 15 can be made true using 6 * 8 || 6 * 15.
// 192: 17 8 14 can be made true using 17 || 8 + 14.
// Adding up all six test values (the three that could be made before using only + and * plus the new three that can now be made by also using ||) produces the new total calibration result of 11387.

// Using your new knowledge of elephant hiding spots, determine which equations could possibly be true. What is their total calibration result?
void main() {
  var listOfString = readFile('lib/days/7/day_7_2.txt');
  List<String> eqnWithoutOperator = [];
  for (var i = 0; i < listOfString.length; i++) {
    eqnWithoutOperator.add(listOfString[i].replaceAll(':', ''));
  }
  print(eqnWithoutOperator.length);
  var availableOperator = ['+', '*', '||'];

  int sum = 0;
  var count = 0;
  for (var i = 0; i < eqnWithoutOperator.length; i++) {
    var equation = eqnWithoutOperator[i].split(' ').sublist(1);
    var equationAnswer = eqnWithoutOperator[i].split(' ').first;
    var possiblePermutation = pow(availableOperator.length, equation.length);
    String eqn = '';
    for (var k = 0; k < possiblePermutation; k++) {
      var bin = k.toRadixString(availableOperator.length);
      var binList = bin.split('');
      while (binList.length < equation.length) {
        binList.insert(0, '0');
      }
      var solution = -1;
      if (int.parse(binList[0]) == 0) {
        solution = 0;
      } else if (int.parse(binList[0]) == 1) {
        solution = 1;
      } else {
        solution = 0;
      }
      for (var l = 0; l < binList.length; l++) {
        if (binList[l] == '0') {
          solution = solution + int.parse(equation[l]);
          eqn = '$eqn+${equation[l]}';
        } else if (binList[l] == '1') {
          eqn = '$eqn*${equation[l]}';
          solution = solution * int.parse(equation[l]);
        } else {
          eqn = '$eqn||${equation[l]}';
          var tempSolution = solution.toString() + equation[l];
          solution = int.parse(tempSolution);
        }
      }
      if (solution == int.parse(equationAnswer)) {
        print('$binList $eqn $equationAnswer');
        sum = sum + solution;
        count++;
        break;
      } else {
        eqn = '';
      }
    }
  }
  print(count);
  print(sum);
}
