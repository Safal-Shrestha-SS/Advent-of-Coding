import 'package:advent_of_coding/file_reader.dart';

// Watching over your shoulder as you work, one of The Historians asks if you took the effects of resonant harmonics into your calculations.

// Whoops!

// After updating your model, it turns out that an antinode occurs at any grid position exactly in line with at least two antennas of the same frequency, regardless of distance. This means that some of the new antinodes will occur at the position of each antenna (unless that antenna is the only one of its frequency).

// So, these three T-frequency antennas now create many antinodes:

// T....#....
// ...T......
// .T....#...
// .........#
// ..#.......
// ..........
// ...#......
// ..........
// ....#.....
// ..........
// In fact, the three T-frequency antennas are all exactly in line with two antennas, so they are all also antinodes! This brings the total number of antinodes in the above example to 9.

// The original example now has 34 antinodes, including the antinodes that appear on every antenna:

// ##....#....#
// .#.#....0...
// ..#.#0....#.
// ..##...0....
// ....0....#..
// .#...#A....#
// ...#..#.....
// #....#.#....
// ..#.....A...
// ....#....A..
// .#........#.
// ...#......##
// Calculate the impact of the signal using this updated model. How many unique locations within the bounds of the map contain an antinode?
void main() {
  var listOfString = readFile('lib/days/8/day_8_2.txt');
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
        uniquePoints.add(a);
        var x = 0;
        var y = 0;
        var x1 = 0;
        var y1 = 0;
        x = a.x - b.x;
        y = a.y - b.y;
        x1 = a.x;
        y1 = a.y;
        while (true) {
          x1 = x1 + x;
          y1 = y1 + y;
          if (x1 >= 0 &&
              x1 < horizontalLengeth &&
              y1 >= 0 &&
              y1 < verticalLength) {
            uniquePoints.add(Point(x1, y1));
          } else {
            break;
          }
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

