// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advent_of_coding/file_reader.dart';
import 'package:dart_console/dart_console.dart';

void main() {
  var listOfString = readFile('lib/days/8/day_8_1.txt');
  List<List<String>> matrix = [];
  Map<String, List<Point>> uniqueMap = {};
  for (var i = 0; i < listOfString.length; i++) {
    matrix.add(listOfString[i].split(''));
    for (var j = 0; j < matrix[i].length; j++) {
      if (matrix[i][j] == '.') {
        continue;
      }
      if (uniqueMap.containsKey(matrix[i][j])) {
        uniqueMap[matrix[i][j]]?.add(Point(j, i));
      } else {
        uniqueMap[matrix[i][j]] = [Point(j, i)];
      }
    }
  }
  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;
  Set<Point> uniquePoints = {};
  for (var i = 0; i < uniqueMap.length; i++) {
    var points = uniqueMap[uniqueMap.keys.elementAt(i)];
    for (var j = 0; j < points!.length; j++) {
      for (var k = 0; k < points.length; k++) {
        if (j == k) {
          continue;
        }
        var a = points[j];
        var b = points[k];
        var x = 0;
        var y = 0;
        var x1 = 0;
        var y1 = 0;
       x = a.x - b.x;
        y = a.y - b.y;
        x1 = a.x+ x;
        y1 = a.y + y;
        if (x1 >= 0 && x1 < horizontalLengeth && y1>= 0 && y1 < verticalLength) {
          // print('x: $x1, y: $y1');
          uniquePoints.add(Point(x1, y1));
        }
      }
    }
  } 
  print(uniquePoints.length);
}

class Point {
  int x;
  int y;
  Point(this.x, this.y);

  @override
  bool operator ==(covariant Point other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Point(x: $x, y: $y)';
}


void printMatrix(List<List<String>> matrix) {
  Console().clearScreen();
  for (var i = 0; i < matrix.length; i++) {
    print(matrix[i]);
  }
}