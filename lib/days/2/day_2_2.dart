import '../../file_reader.dart';

// The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener.

// The Problem Dampener is a reactor-mounted module that lets the reactor safety systems tolerate a single bad level in what would otherwise be a safe report. It's like the bad level never happened!

// Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

// More of the above example's reports are now safe:

// 7 6 4 2 1: Safe without removing any level.
// 1 2 7 8 9: Unsafe regardless of which level is removed.
// 9 7 6 2 1: Unsafe regardless of which level is removed.
// 1 3 2 4 5: Safe by removing the second level, 3.
// 8 6 4 4 1: Safe by removing the third level, 4.
// 1 3 6 7 9: Safe without removing any level.
// Thanks to the Problem Dampener, 4 reports are actually safe!

// Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?
void main() {
  var listOfString = readFile('lib/days/2/day_2_2.txt');
  List<List<int>> reports = [];
  for (var i = 0; i < listOfString.length; i++) {
    var temp = listOfString[i].split(' ');
    temp.removeWhere((element) => element.isEmpty);
    var a = temp.map((e) {
      return int.parse(e.trim());
    }).toList();
    reports.add(a);
  }
  reports.removeWhere((element) => element.isEmpty);
  var safe = 0;
  for (var report in reports) {
    var removedIndex = -1;
    var tempList = [...report];
    while (true) {
      var a = newMethod(report);
      if (a) {
        safe++;
        break;
      }
      if(removedIndex == report.length ){
        break;
      }
      removedIndex ++;
      var b = [...tempList];
      report.clear();
      report.addAll([...b]);
      report.removeAt(removedIndex);
    }
    
  }
  print(safe);
}

bool newMethod(List<int> report) {
  bool isSafe = true;
  bool isIncreasing = report[0] < report[1];
  var i = 0;
  for ( i = 0; i < report.length - 1; i++) {
    if (report[i] == report[i + 1]) {
      print(report);
      isSafe = false;
      break;
    }
    if ((report[i] < report[i + 1]) != isIncreasing) {
      print(report);
      isSafe = false;
      break;
    }
    if ((report[i] - report[i + 1]).abs() > 3) {
      print('more than 3' '$report  with values ${report[i] - report[i + 1]} and ${report[i + 1]}');
      isSafe = false;
      break;
    }
  }
  return isSafe;
}

