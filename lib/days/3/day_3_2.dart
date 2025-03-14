import '../../file_reader.dart';


// As you scan through the corrupted memory, you notice that some of the conditional statements are also still intact. If you handle some of the uncorrupted conditional statements in the program, you might be able to get an even more accurate result.

// There are two new instructions you'll need to handle:

// The do() instruction enables future mul instructions.
// The don't() instruction disables future mul instructions.
// Only the most recent do() or don't() instruction applies. At the beginning of the program, mul instructions are enabled.

// For example:

// xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
// This corrupted memory is similar to the example from before, but this time the mul(5,5) and mul(11,8) instructions are disabled because there is a don't() instruction before them. The other mul instructions function normally, including the one at the end that gets re-enabled by a do() instruction.

// This time, the sum of the results is 48 (2*4 + 8*5).

// Handle the new instructions; what do you get if you add up all of the results of just the enabled multiplications?
void main() {
  var listOfString = readFile('lib/days/3/day_3_2.txt');
  var fileString = '${listOfString.join()}do()';
  var sum = 0;

  fileString =
      fileString.replaceAllMapped(RegExp(r"don't\(\).*?do\(\)"), (match) {
    return 'safal';
  });
  String temp = '';
  temp = fileString.replaceAllMapped(RegExp(r"don't\(\).*?do\(\)"), (match) {
    return 'safal';
  });

  List<RegExpMatch> regexList = [];
  final regex = RegExp(r'mul\([0-9]{1,3},[0-9]{1,3}\)');
  final digitRegex = RegExp(r'[0-9]+');
  regexList.addAll(regex.allMatches(temp));
  for (var i = 0; i < regexList.length; i++) {
    // print(regexList.elementAt(i).group(0));
    var temp = regexList.elementAt(i).group(0)!.split(',');
    var first = int.parse(digitRegex.firstMatch(temp[0])!.group(0)!);
    var second = int.parse(digitRegex.firstMatch(temp[1])!.group(0)!);
    // print('$first * $second = ${first * second}');
    sum = sum + (first * second);
  }
  print(sum);
}
