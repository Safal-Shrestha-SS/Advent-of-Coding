// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advent_of_coding/file_reader.dart';

void main() {
  var listOfString = readFile('lib/days/12/day_12_2.txt');
  List<List<String>> matrix = [];
  for (var i = 0; i < listOfString.length; i++) {
    matrix.add(listOfString[i].split(''));
  }
  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;

  Map<String, List<Point>> uniqueMap = {};
  for (var y = 0; y < verticalLength; y++) {
    for (var x = 0; x < horizontalLengeth; x++) {
      if (seen.contains((x, y))) {
        continue;
      }
      uniqueMap['$y,$x'] = tracePath(x, y, matrix[y][x], matrix);
    }
  }
  int sum = 0;
  // var loop = 0;
  for (var i in uniqueMap.entries) {
    // loop++;
    // if (loop < 4) continue;
    var maxX = 0;
    var maxY = 0;
    int? minX;
    int? minY;
    int totalSide = 0;
    for (var j in i.value) {
      if (j.x > maxX) {
        maxX = j.x;
      }
      if (j.y > maxY) {
        maxY = j.y;
      }
      if (minX == null || j.x < minX) {
        minX = j.x;
      }
      if (minY == null || j.y < minY) {
        minY = j.y;
      }
    }
    print('key: ${i.key}');
    List<List<String>> a = List.generate(
        maxY - minY! + 3, (index) => List.filled(maxX - minX! + 3, '.'));
    for (var j in i.value) {
      a[j.y - minY + 1][j.x - minX! + 1] = 'A';
    }
    // printMatrix(a);
    int totalSideX = 0;
    for (var h = 0; h < a.length; h++) {
      int sideX = 0;
      int previousSide = -1;
      for (var k = 0; k < a[0].length; k++) {
        if (a[h][k] != '.') {
          previousSide = -1;
          continue;
        }
        if (a[h][k] == '.') {
          int tempSideX = 0;
          for (var d in [-1, 1]) {
            if (h + d < 0 || h + d >= a.length) {
              continue;
            }
            if (a[h + d][k] == 'A') {
              tempSideX++;
            }
          }
          if (previousSide != tempSideX) {
            if (previousSide == 2 && tempSideX == 1) {
              sideX = sideX;
            } else if (previousSide == 1 && tempSideX == 2) {
              sideX += 1;
            } else {
              sideX += tempSideX;
            }
            previousSide = tempSideX;
          }
        }
      }
      totalSideX += sideX;
      // print(sideX);
    }
    int totalSideY = 0;
    for (var k = 0; k < a[0].length; k++) {
      int sideY = 0;
      int previousSide = -1;
      for (var h = 0; h < a.length; h++) {
        if (a[h][k] != '.') {
          previousSide = -1;
          continue;
        }
        if (a[h][k] == '.') {
          int tempSideY = 0;
          for (var d in [-1, 1]) {
            if (k + d < 0 || k + d >= a[0].length) {
              continue;
            }
            if (a[h][k + d] == 'A') {
              tempSideY++;
            }
          }
          if (previousSide != tempSideY) {
            if (previousSide == 2 && tempSideY == 1) {
              sideY = sideY;
            } else if (previousSide == 1 && tempSideY == 2) {
              sideY += 1;
            } else {
              sideY += tempSideY;
            }
            previousSide = tempSideY;
          }
        }
      }
      totalSideY += sideY;
      // print(sideY);
    }
    print(totalSideX);
    print(totalSideY);

    // if(totalSideX % 2 != 0) {
    //   totalSideX = totalSideX - 1;
    // }
    // if(totalSideY % 2 != 0) {
    //   totalSideY = totalSideY - 1;
    // }
    totalSide = totalSideX + totalSideY;
    // if (totalSide % 2 != 0) {
    //   totalSide = totalSide - 1;
    // }
    print(
        'Total side: $totalSide with x side $totalSideX and $totalSideY for ${i.key}');
    sum += (totalSide * i.value.length);
    printMatrix(a);
    print('-------------------');
  }
  print(sum);
  // print(uniqueMap);
}

var direction = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0]
];
Map<String, List<Point>> uniqueMap = {};
Set<(int, int)> seen = {};
List<Point> tracePath(
    int x, int y, String currentValue, List<List<String>> grid) {
  List<Point> trace = [];
  var perimeter = 4;
  for (var i in direction) {
    var newX = x + i[1];
    var newY = y + i[0];
    if (newX >= 0 && newX < grid[0].length && newY >= 0 && newY < grid.length) {
      if (grid[newY][newX] == currentValue) {
        perimeter--;
      }
    }
  }
  trace.add(Point(x, y, perimeter));
  seen.add((x, y));
  for (var i in direction) {
    var newX = x + i[1];
    var newY = y + i[0];
    if (seen.contains((newX, newY))) {
      continue;
    }
    if (newX >= 0 && newX < grid[0].length && newY >= 0 && newY < grid.length) {
      if (grid[newY][newX] == currentValue) {
        trace.addAll(tracePath(newX, newY, currentValue, grid));
      }
    }
  }
  return trace;
}

class Point {
  int x;
  int y;
  int perimeter;
  Point(this.x, this.y, this.perimeter);

  @override
  bool operator ==(covariant Point other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y && other.perimeter == perimeter;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ perimeter.hashCode;

  @override
  String toString() => 'Point(x: $x, y: $y, perimeter: $perimeter)';
}

void printMatrix(List<List<String>> matrix) {
  
  for (var i = 0; i < matrix.length; i++) {
    print("$i: ${matrix[i]}");
  }
}
