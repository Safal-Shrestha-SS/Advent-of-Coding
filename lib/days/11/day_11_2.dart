import 'package:advent_of_coding/file_reader.dart';

// The Historians sure are taking a long time. To be fair, the infinite corridors are very large.

// How many stones would you have after blinking a total of 75 times?
void main() {
  var listOfString = readFile('lib/days/11/day_11_2.txt');
  List<String> noList = listOfString[0].split(' ');

  print(noList);
  Stopwatch stopwatch = Stopwatch()..start();
  const noOfBlinks = 25;

  int count = 0;
  for (var i = 0; i < noList.length; i++) {
    count += listLength(int.parse(noList[i]), noOfBlinks);
  }

  print(count);
  // print(cache);
  print('Execution took ${stopwatch.elapsed}');
}

Map<String, int> cache = {};

int listLength(int listValue, int step) {
  if (step == 0) return 1;

  String key = '$listValue,$step';

  if (!cache.containsKey(key)) {
    int result = 0;

    if (listValue == 0) {
      result = listLength(1, step - 1);
    } else if (listValue.toString().length % 2 == 0) {
      String str = listValue.toString();
      int mid = str.length ~/ 2;

      result += listLength(int.parse(str.substring(0, mid)), step - 1);
      result += listLength(int.parse(str.substring(mid)), step - 1);
    } else {
      result = listLength(listValue * 2024, step - 1);
    }

    cache[key] = result;
  }

  return cache[key]!;
}
