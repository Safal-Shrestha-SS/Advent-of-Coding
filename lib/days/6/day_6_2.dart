// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advent_of_coding/file_reader.dart';
import 'package:dart_console/dart_console.dart';

List<XYpoint> possiblePaths = [];

void printMatrix(List<List<String>> matrix) {
  Console().clearScreen();
  for (var i = 0; i < matrix.length; i++) {
    print(matrix[i]);
  }
}

void main() async {
  var listOfString = readFile('lib/days/6/day_6_1.txt');

  List<List<String>> matrix = [];
  List<List<String>> countMatrix = [];
  var positionIntX = 0;
  var positionIntY = 0;
  String direction = '';
  int ggg = 0;
  int noOfObstacles = 0;
  for (var i = 0; i < listOfString.length; i++) {
    matrix.add(listOfString[i].split(''));
    noOfObstacles = noOfObstacles +
        listOfString[i].split('').where((element) => element == '#').length;
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
  List<List<String>> temp = deepCopy(matrix);
  getDistinctPosition(direction, positionIntX, positionIntY, deepCopy(temp));
  for (var i = 1; i < possiblePaths.length; i++) {
    countMatrix.clear();
    countMatrix = deepCopy(temp);
    if (countMatrix[possiblePaths[i].y][possiblePaths[i].x] != direction) {
      countMatrix[possiblePaths[i].y][possiblePaths[i].x] = '#';
    }
    var stuck = isStuck(direction, positionIntX, positionIntY,
        deepCopy(countMatrix), noOfObstacles);
    print(i);
    if (stuck) {
      ggg++;
    }
  }
  print(ggg);
}

bool isStuck(String startDirection, int posX, int posY,
    List<List<String>> matrix, int noOfObstacles) {
  var positionIntX = posX;
  var positionIntY = posY;
  String direction = startDirection;
  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;
  var stuck = false;
  Set<XYpoint> a = {};
  a.add(XYpoint(positionIntX, positionIntY));
  Set<XYpointWithDirection> b = {};
  b.add(XYpointWithDirection(positionIntX, positionIntY, direction));
  var addObstacle = false;
  int obstacleCount = 0;
  obstacleCount = matrix
      .map((e) => e.where((element) => element == '#').length)
      .reduce((value, element) => value + element);
  if (obstacleCount == noOfObstacles) {
    addObstacle = true;
  }
  var loopCount = 0;
  while (true) {
    // printMatrix(matrix);
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
        matrix[positionIntY][positionIntX] = direction;
      } else {
        if (direction == matrix[newPosY][newPosX]) {
          stuck = true;
          break;
        }
        positionIntX = newPosX;
        positionIntY = newPosY;
        if (b.contains(
            XYpointWithDirection(positionIntX, positionIntY, direction))) {
          stuck = true;

          break;
        }
        b.add(XYpointWithDirection(positionIntX, positionIntY, direction));
        matrix[positionIntY][positionIntX] = direction;
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
    if (addObstacle && loopCount == 1) {
      matrix[positionIntY][positionIntX] = '#';
      addObstacle = false;
    }
    loopCount++;
  }

  return stuck;
}

int getDistinctPosition(
    String startDirection, int posX, int posY, List<List<String>> matrix) {
  var positionIntX = posX;
  var positionIntY = posY;
  String direction = startDirection;
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
  }
  print(a.length);
  possiblePaths.clear();
  possiblePaths.addAll(a);
  return a.length;
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

class XYpointWithDirection {
  final int x;
  final int y;
  final String direction;

  const XYpointWithDirection(this.x, this.y, this.direction);

  @override
  bool operator ==(covariant XYpointWithDirection other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y && other.direction == direction;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ direction.hashCode;
}

List<List<String>> deepCopy(List<List<String>> original) {
  return original.map((innerList) => List<String>.from(innerList)).toList();
}
