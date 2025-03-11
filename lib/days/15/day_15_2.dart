import 'package:advent_of_coding/file_reader.dart';

void main() {
  var listOfString = readFile('lib/days/15/day_15_2.txt');
  List<List<String>> grid = [[]];
  List<String> directions = [];
  int breakPoint = 0;

  var robotPosition = (0, 0, '@');
  for (var i = 0; i < listOfString.length; i++) {
    if (listOfString[i].isEmpty) {
      breakPoint = i;
      break;
    }
    var row = listOfString[i].split('');
    var rowToAdd = <String>[];
    for (var k = 0; k < row.length; k++) {
      var j = row[k];
      if (j == ".") {
        rowToAdd.addAll([".", "."]);
      }
      if (j == "#") {
        rowToAdd.addAll(["#", "#"]);
      }
      if (j == "O") {
        rowToAdd.addAll(["[", "]"]);
      }
      if (j == '@') {
        robotPosition = (i, rowToAdd.length, '@');
        rowToAdd.addAll(["@", "."]);
      }
    }
    grid.add(rowToAdd);
  }
  grid.removeAt(0);
  for (var i = breakPoint + 1; i < listOfString.length; i++) {
    directions.addAll(listOfString[i].split(''));
  }
  printMatrix(grid);
  for (var i = 0; i < 1; i++) {
    var direction = directions[i];
    List<List<(int, int, String)>> boxes = [];
    var tempPosition = robotPosition;
    var move = false;
    if (direction == '<') {
      while (true) {
        tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '@');
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          tempPosition = (tempPosition.$1, tempPosition.$2, '.');
          boxes.add([tempPosition]);
          break;
        }
        boxes.add([
          (
            tempPosition.$1,
            tempPosition.$2,
            grid[tempPosition.$1][tempPosition.$2]
          )
        ]);
      }
    }
    if (direction == '>') {
      while (true) {
        tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '@');
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '.');

          boxes.add([tempPosition]);
          break;
        }
        boxes.add([
          (
            tempPosition.$1,
            tempPosition.$2 - 1,
            grid[tempPosition.$1][tempPosition.$2]
          )
        ]);
      }
    }
    if (direction == '^') {
      tempPosition = robotPosition;
      while (true) {
        if (boxes.isEmpty) {
          if (grid[robotPosition.$1 - 1][robotPosition.$2] == '[') {
            boxes.addAll([
              [robotPosition, (robotPosition.$1, robotPosition.$2 + 1, '.')],
            ]);
          }
          if (grid[robotPosition.$1 - 1][robotPosition.$2] == '[') {
            boxes.addAll([
              [robotPosition, (robotPosition.$1, robotPosition.$2 - 1, '.')],
            ]);
          }
        }
        tempPosition = (tempPosition.$1 - 1, tempPosition.$2, '@');
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          if (grid[tempPosition.$1 - 1][tempPosition.$2] == '[') {
            if (grid[tempPosition.$1][tempPosition.$2 + 1] == '.') {
              move = true;
              // tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '.');
              boxes.add([tempPosition]);
              break;
            }
            if (grid[tempPosition.$1 - 1][tempPosition.$2] == ']') {
              move = true;
              // tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '.');
              boxes.add([tempPosition]);
              break;
            }
          }
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '[') {
          boxes.add([
            (tempPosition.$1, tempPosition.$2, '['),
            (tempPosition.$1 + 1, tempPosition.$2, ']')
          ]);
        }
        if (grid[tempPosition.$1][tempPosition.$2] == ']') {
          boxes.add([
            (tempPosition.$1, tempPosition.$2, ']'),
            (tempPosition.$1 - 1, tempPosition.$2, '[')
          ]);
        }
      }
      print(boxes);
    }
    if (direction == 'v') {
      while (true) {
        tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '@');
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          if (grid[tempPosition.$1 + 1][tempPosition.$2] == '[') {
            if (grid[tempPosition.$1][tempPosition.$2 + 1] == '.') {
              move = true;
              // tempPosition = (tempPosition.$1, tempPosition.$2 , '.');
              boxes.add([tempPosition]);
              break;
            }
            if (grid[tempPosition.$1 - 1][tempPosition.$2] == ']') {
              move = true;
              // tempPosition = (tempPosition.$1, tempPosition.$2 - 1, '.');
              boxes.add([tempPosition]);
              break;
            }
          }
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '[') {
          boxes.add([
            (tempPosition.$1, tempPosition.$2, '['),
            (tempPosition.$1 - 1, tempPosition.$2, ']')
          ]);
        }
        if (grid[tempPosition.$1][tempPosition.$2] == ']') {
          boxes.add([
            (tempPosition.$1, tempPosition.$2, ']'),
            (tempPosition.$1 + 1, tempPosition.$2, '[')
          ]);
        }
      }
    }
    print('movable $move and directin $direction');
    if (move) {
      grid[robotPosition.$1][robotPosition.$2] = '.';
      robotPosition = boxes.first.first;
      if (direction == '<' || direction == '>') {
        print(boxes.first.first);
        grid[boxes.first.first.$1][boxes.first.first.$2] = '@';
        for (var i = 1; i < boxes.length; i++) {
          grid[boxes[i].first.$1][boxes[i].first.$2] = boxes[i - 1].first.$3;
        }
        continue;
      }
      if (direction == '^') {
        print('moving up');
        // grid[boxes.first.first.$1][boxes.first.first.$2] = '@';
        grid[boxes.first[1].$1][boxes.first[1].$2] = ".";
        for (var i = 0; i < boxes.length; i++) {
          for (var j = 0; j < boxes[i].length; j++) {
            grid[boxes[i][j].$1 - 1][boxes[i][j].$2] = boxes[i][j].$3;
          }
        }
        continue;
      }
      if (direction == 'v') {
        // grid[boxes.first.first.$1][boxes.first.first.$2] = '@';
        grid[boxes.first[1].$1][boxes.first[1].$2] = ".";
        for (var i = 0; i < boxes.length; i++) {
          for (var j = 0; j < boxes[i].length; j++) {
            grid[boxes[i][j].$1 + 1][boxes[i][j].$2] = boxes[i][j].$3;
          }
        }
        continue;
      }
    }
    printMatrix(grid);
    boxes.clear();
  }
  printMatrix(grid);

  // var sum = 0;
  // for (var i = 0; i < grid.length; i++) {
  //   for (var j = 0; j < grid[0].length; j++) {
  //     if (grid[i][j] == 'O') {
  //       sum += (100 * i + j);
  //     }
  //   }
  // }
  // print(sum);
}

void printMatrix(List<List<String>> matrix) {
  for (var i = 0; i < matrix.length; i++) {
    var j = matrix[i].join('');
    print(j);
  }
}
