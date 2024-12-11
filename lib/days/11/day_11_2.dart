import 'package:advent_of_coding/file_reader.dart';

void main() {
  var listOfString = readFile('lib/days/11/day_11_2.txt');
  List<String> noList = listOfString[0].split(' ');

  print(noList);
  Stopwatch stopwatch = Stopwatch()..start();
  const noOfBlinks = 75;
  int count = 0;
  for (var i = 0; i < noList.length; i++) {
    count += listLength(noList[i], noOfBlinks);
  }
  // Use a fixed-length list for performance optimization
  print(count);
  print('do() execution took ${stopwatch.elapsed}');
}

int listLength(String listValue, int step) {
  if (step == 0) {
    return 1;
  }
  if (listValue == '0') {
    return listLength('1', step - 1);
  }
  if (listValue.length % 2 == 0) {
    return listLength(listValue.substring(0, listValue.length ~/ 2), step - 1) +
        listLength(
            int.parse(listValue.substring(listValue.length ~/ 2)).toString(),
            step - 1);
  }
  return listLength((int.parse(listValue) * 2024).toString(), step - 1);
}
