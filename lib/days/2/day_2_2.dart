import '../../file_reader.dart';

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
      print('more than 3' +
          '$report  with values ${report[i] - report[i + 1]} and ${report[i + 1]}');
      isSafe = false;
      break;
    }
  }
  return isSafe;
}

