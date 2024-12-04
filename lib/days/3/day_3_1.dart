import '../../file_reader.dart';

// The shopkeeper turns to you. "Any chance you can see why our computers are having issues again?"

// The computer appears to be trying to run a program, but its memory (your puzzle input) is corrupted. All of the instructions have been jumbled up!

// It seems like the goal of the program is just to multiply some numbers. It does that with instructions like mul(X,Y), where X and Y are each 1-3 digit numbers. For instance, mul(44,46) multiplies 44 by 46 to get a result of 2024. Similarly, mul(123,4) would multiply 123 by 4.

// However, because the program's memory has been corrupted, there are also many invalid characters that should be ignored, even if they look like part of a mul instruction. Sequences like mul(4*, mul(6,9!, ?(12,34), or mul ( 2 , 4 ) do nothing.

// For example, consider the following section of corrupted memory:

// xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
// Only the four highlighted sections are real mul instructions. Adding up the result of each instruction produces 161 (2*4 + 5*5 + 11*8 + 8*5).

// Scan the corrupted memory for uncorrupted mul instructions. What do you get if you add up all of the results of the multiplications?
void main() {
  var listOfString = readFile('lib/days/3/day_3_1.txt');
  var sum = 0;
  List<RegExpMatch> regexList = [];
  final regex = RegExp(r'mul\([0-9]+,[0-9]+\)');
  final digitRegex = RegExp(r'[0-9]+');
  for(var i in listOfString){
    regexList.addAll(regex.allMatches(i));
  }
  
  for (var i = 0; i < regexList.length; i++) {
    var temp = regexList.elementAt(i).group(0)!.split(',');
    var first = int.parse(digitRegex.firstMatch(temp[0])!.group(0)!);
    var second = int.parse(digitRegex.firstMatch(temp[1])!.group(0)!);
    sum += first * second;
  }
  print(sum);
}
