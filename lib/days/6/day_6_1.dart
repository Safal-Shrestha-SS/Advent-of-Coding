// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dart_console/dart_console.dart';

import 'package:advent_of_coding/file_reader.dart';

// The Historians use their fancy device again, this time to whisk you all away to the North Pole prototype suit manufacturing lab... in the year 1518! It turns out that having direct access to history is very convenient for a group of historians.

// You still have to be careful of time paradoxes, and so it will be important to avoid anyone from 1518 while The Historians search for the Chief. Unfortunately, a single guard is patrolling this part of the lab.

// Maybe you can work out where the guard will go ahead of time so that The Historians can search safely?

// You start by making a map (your puzzle input) of the situation. For example:

// ....#.....
// .........#
// ..........
// ..#.......
// .......#..
// ..........
// .#..^.....
// ........#.
// #.........
// ......#...
// The map shows the current position of the guard with ^ (to indicate the guard is currently facing up from the perspective of the map). Any obstructions - crates, desks, alchemical reactors, etc. - are shown as #.

// Lab guards in 1518 follow a very strict patrol protocol which involves repeatedly following these steps:

// If there is something directly in front of you, turn right 90 degrees.
// Otherwise, take a step forward.
// Following the above protocol, the guard moves up several times until she reaches an obstacle (in this case, a pile of failed suit prototypes):

// ....#.....
// ....^....#
// ..........
// ..#.......
// .......#..
// ..........
// .#........
// ........#.
// #.........
// ......#...
// Because there is now an obstacle in front of the guard, she turns right before continuing straight in her new facing direction:

// ....#.....
// ........>#
// ..........
// ..#.......
// .......#..
// ..........
// .#........
// ........#.
// #.........
// ......#...
// Reaching another obstacle (a spool of several very long polymers), she turns right again and continues downward:

// ....#.....
// .........#
// ..........
// ..#.......
// .......#..
// ..........
// .#......v.
// ........#.
// #.........
// ......#...
// This process continues for a while, but the guard eventually leaves the mapped area (after walking past a tank of universal solvent):

// ....#.....
// .........#
// ..........
// ..#.......
// .......#..
// ..........
// .#........
// ........#.
// #.........
// ......#v..
// By predicting the guard's route, you can determine which specific positions in the lab will be in the patrol path. Including the guard's starting position, the positions visited by the guard before leaving the area are marked with an X:

// ....#.....
// ....XXXXX#
// ....X...X.
// ..#.X...X.
// ..XXXXX#X.
// ..X.X.X.X.
// .#XXXXXXX.
// .XXXXXXX#.
// #XXXXXXX..
// ......#X..
// In this example, the guard will visit 41 distinct positions on your map.

// Predict the path of the guard. How many distinct positions will the guard visit before leaving the mapped area?
void main() async {
  var listOfString = readFile('lib/days/6/day_6_1.txt');

  List<List<String>> matrix = [];
  var positionIntX = 0;
  var positionIntY = 0;
  String direction = '';
  for (var i = 0; i < listOfString.length; i++) {
    matrix.add(listOfString[i].split(''));
    if (listOfString[i].contains('v')) {
      positionIntY = i;
      positionIntX = listOfString[i].indexOf('v');
      direction = 'v';
    }
    if (listOfString[i].contains('<')) {
      positionIntY = i;
      positionIntX = listOfString[i].indexOf('<');
      direction = '<';
    }
    if (listOfString[i].contains('>')) {
      positionIntY = i;
      positionIntX = listOfString[i].indexOf('>');
      direction = '>';
    }
    if (listOfString[i].contains('^')) {
      positionIntY = i;
      positionIntX = listOfString[i].indexOf('^');
      direction = '^';
    }
  }

  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;
  Set<XYpoint> a = {};
  a.add(XYpoint(positionIntX, positionIntY));
  // listOfString
  while (true) {
    var newPosX = 0;
    var newPosY = 0;
    var newDirection = '';
    if (direction == 'v') {
      newPosX = positionIntX;
      newPosY = positionIntY + 1;
      newDirection = '<';
    } else if (direction == '<') {
      newPosX = positionIntX - 1;
      newPosY = positionIntY;
      newDirection = '^';
    } else if (direction == '>') {
      newPosX = positionIntX + 1;
      newPosY = positionIntY;
      newDirection = 'v';
    } else if (direction == '^') {
      newPosX = positionIntX;
      newPosY = positionIntY - 1;
      newDirection = '>';
    }
    try {
      if (matrix[newPosY][newPosX] == '#') {
        direction = newDirection;
      } else {
        positionIntX = newPosX;
        positionIntY = newPosY;
        if (matrix[positionIntY][positionIntX] != 'X') {
          a.add(XYpoint(positionIntX, positionIntY));
          matrix[positionIntY][positionIntX] = 'X';
        }

        // throttler.run(() => drawMatrix(
        //       matrix,
        //       positionIntX,
        //       positionIntY,
        //       direction,
        //     ));

        if (positionIntX >= horizontalLengeth ||
            positionIntX < 0 ||
            positionIntY >= verticalLength ||
            positionIntY < 0) {
          {
            break;
          }
        }
      }
    } catch (_) {
      break;
    }

    // print('positionIntX: $positionIntX, positionIntY: $positionIntY, direction: $direction and sum: $sum');
    // printMatrix(matrix);
    // print(sum);
  }
  print(
      'positionIntX: $positionIntX, positionIntY: $positionIntY, direction: $direction ');
  print(a.length);
  // drawMatrix(matrix, positionIntX, positionIntY, direction);
}

void printMatrix(List<List<String>> matrix) {
  for (var i = 0; i < matrix.length; i++) {
    print(matrix[i]);
  }
}

final Console console = Console();
final throttler = Throttler(milliseconds: 100);

// void drawMatrix(
//     List<List<String>> matrix, int posX, int posY, String direction) {
//   console.clearScreen();
//   console.cursorPosition = Coordinate(0, 0);

//   for (int y = 0; y < matrix.length; y++) {
//     for (int x = 0; x < matrix[y].length; x++) {
//       if (x == posX && y == posY) {
//         console.setForegroundColor(ConsoleColor.brightGreen);
//         console.write(direction);
//       } else if (matrix[y][x] == '#') {
//         console.setForegroundColor(ConsoleColor.red);
//         console.write('#');
//       } else if (matrix[y][x] == 'X') {
//         console.setForegroundColor(ConsoleColor.brightYellow);
//         console.write('X');
//       } else {
//         console.resetColorAttributes();
//         console.write('.');
//       }
//     }
//     console.writeLine();
//   }
// }

void drawMatrix(
    List<List<String>> matrix, int posX, int posY, String direction) {
  final buffer = StringBuffer();

  // Build the matrix in memory
  for (int y = 0; y < matrix.length; y++) {
    for (int x = 0; x < matrix[y].length; x++) {
      if (x == posX && y == posY) {
        buffer
            .write('\x1B[32m$direction\x1B[0m'); // Green for the moving symbol
      } else if (matrix[y][x] == '#') {
        buffer.write('\x1B[31m#\x1B[0m'); // Red for obstacles
      } else if (matrix[y][x] == 'X') {
        console.setForegroundColor(ConsoleColor.brightYellow);
        console.write('X');
      } else {
        buffer.write('.'); // Default for empty space
      }
    }
    buffer.write('\n');
  }

  // Move cursor to the top-left and write the buffer
  console.cursorPosition = Coordinate(0, 0);
  console.write(buffer.toString());
}

class XYpoint {
  final int x;
  final int y;

  const XYpoint(this.x, this.y);

  @override
  String toString() {
    return 'XYpoint($x, $y)';
  }

  @override
  bool operator ==(covariant XYpoint other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class Throttler {
  final int milliseconds;

  int _lastActionTime;

  int get _millisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  Throttler({required this.milliseconds})
      : _lastActionTime = DateTime.now().millisecondsSinceEpoch;

  void run(void Function() action) {
    if (_millisecondsSinceEpoch - _lastActionTime > milliseconds) {
      action();
      _lastActionTime = _millisecondsSinceEpoch;
    }
  }
}

// Move the cursor to a specific position (x, y) on the console.
void moveCursor(int x, int y) {
  print('\x1B[${y + 1};${x + 1}H');
}

// Print a single character at the current cursor position.
void printChar(String char) {
  stdout.write(char);
}
