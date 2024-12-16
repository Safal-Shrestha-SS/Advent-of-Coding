import 'dart:io';

import 'package:advent_of_coding/file_reader.dart';

// During the bathroom break, someone notices that these robots seem awfully similar to ones built and used at the North Pole. If they're the same type of robots, they should have a hard-coded Easter egg: very rarely, most of the robots should arrange themselves into a picture of a Christmas tree.

// What is the fewest number of seconds that must elapse for the robots to display the Easter egg?
void main() {
  var listOfString = readFile('lib/days/14/day_14_2.txt');
  listOfString.removeWhere((element) => element.isEmpty);
  var width = 101;
  var height = 103;
  var noOfSeconds = width * height;

  Map<int, (int, int, int, int)> robots = {};
  var noOfGuard = listOfString.length;
  RegExp regExp = RegExp(r'-?\d+');
  for (var i = 0; i < noOfGuard; i++) {
    var match = regExp.allMatches(listOfString[i]);
    var x = int.parse(match.elementAt(0).group(0)!);
    var y = int.parse(match.elementAt(1).group(0)!);
    var u = int.parse(match.elementAt(2).group(0)!);
    var v = int.parse(match.elementAt(3).group(0)!);
    robots[i] = (x, y, u, v);
  }
  for (var i = 0; i < noOfSeconds; i++) {
    var grid = List.generate(height, (i) => List.generate(width, (j) => '.'));
    for (var j = 0; j < robots.length; j++) {
      var robot = robots[j];
      var newPositionX = robot!.$1 + robot.$3;
      var newPositionY = robot.$2 + robot.$4;
      if (newPositionX < 0) {
        newPositionX = newPositionX + width;
      }
      if (newPositionX >= width) {
        newPositionX = newPositionX - width;
      }
      if (newPositionY < 0) {
        newPositionY = newPositionY + height;
      }
      if (newPositionY >= height) {
        newPositionY = newPositionY - height;
      }
      robots[j] = (newPositionX, newPositionY, robot.$3, robot.$4);
      grid[newPositionY][newPositionX] = '#';
    }
    writeGridToFile(grid, i+1);
  }

}
//7569 answer

void printMatrix(List<List<String>> matrix) {
  for (var i = 0; i < matrix.length; i++) {
    print("${matrix[i]}");
  }
}

void writeGridToFile(List<List<String>> grid, int index) {
  var file = 'lib/days/14/day_14_2_solution.txt';
  var buffer = StringBuffer();
  buffer.write("$index \n");
  for (var i = 0; i < grid.length; i++) {
    buffer.write("${grid[i]}\n");
  }
  writeToFile(file, buffer.toString());
}

void writeToFile(String path, String text) {
  try {
    var file = File(path);
    file.writeAsStringSync(text, mode: FileMode.append);
  } catch (_) {}
}
