import '../../file_reader.dart';
// This time, you'll need to figure out exactly how often each number from the left list appears in the right list. Calculate a total similarity score by adding up each number in the left list after multiplying it by the number of times that number appears in the right list.

// Here are the same example lists again:

// 3   4
// 4   3
// 2   5
// 1   3
// 3   9
// 3   3
// For these example lists, here is the process of finding the similarity score:

// The first number in the left list is 3. It appears in the right list three times, so the similarity score increases by 3 * 3 = 9.
// The second number in the left list is 4. It appears in the right list once, so the similarity score increases by 4 * 1 = 4.
// The third number in the left list is 2. It does not appear in the right list, so the similarity score does not increase (2 * 0 = 0).
// The fourth number, 1, also does not appear in the right list.
// The fifth number, 3, appears in the right list three times; the similarity score increases by 9.
// The last number, 3, appears in the right list three times; the similarity score again increases by 9.
// So, for these example lists, the similarity score at the end of this process is 31 (9 + 4 + 0 + 0 + 9 + 9).

// Once again consider your left and right lists. What is their similarity score?
void main() {
  var listOfString = readFile('lib/days/1/day_1_2.txt');
  var result = <String>[];
  for (var i = 0; i < listOfString.length; i++) {
    var temp = listOfString[i].split(' ');
    for (var j = 0; j < temp.length; j++) {
      result.add(temp[j].trim());
    }
  }
  result.removeWhere((element) => element.isEmpty);

  var firstList = <int>[];
  var secondList = <int>[];
  for (var i = 0; i < result.length; i++) {
    if (i % 2 == 0) {
      firstList.add(int.parse(result[i]));
    } else {
      secondList.add(int.parse(result[i]));
    }
  }
  final length = firstList.length;
  var sum = 0;
  for (var i = 0; i < length; i++) {
    var count = secondList.where((element) => element == firstList[i]).length;
    sum += firstList[i] * count;
  }
  print(sum);
}
