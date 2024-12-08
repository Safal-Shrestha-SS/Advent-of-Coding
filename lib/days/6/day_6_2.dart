// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advent_of_coding/file_reader.dart';

List<XYpoint> possiblePaths = [];
Set<XYpointWithDirection> stuckPaths = {};
void main() async {
  var listOfString = readFile('lib/days/6/day_6_2.txt');

  Set<XYpoint> obsPoint = {};
  List<List<String>> matrix = [];
  List<List<String>> countMatrix = [];
  var positionIntX = 0;
  var positionIntY = 0;
  String direction = '';
  int ggg = 0;
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

  var getMaxLoopValue =
      getDistinctPosition(direction, positionIntX, positionIntY, [...matrix]);
  for (var i = 0; i < possiblePaths.length; i++) {
    countMatrix.clear();
    countMatrix = [...matrix];
    countMatrix[possiblePaths[i].y][possiblePaths[i].x] = '#';
    var stuck = isStuck(direction, possiblePaths[i].x, possiblePaths[i].y,
        countMatrix, getMaxLoopValue);
    if (stuck) {
      ggg++;
      // obsPoint.add(XYpoint(possiblePaths[i].x, possiblePaths[i].y));
    }
  }
  print(ggg);
}

bool isStuck(String startDirection, int posX, int posY,
    List<List<String>> matrix, int loopCount) {
  var positionIntX = posX;
  var positionIntY = posY;
  String direction = startDirection;
  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;
  var stuck = false;
  Set<XYpoint> a = {};
  a.add(XYpoint(positionIntX, positionIntY));
  Set<XYpointWithDirection> b = {};
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
      if (matrix[newPosY][newPosX] == '#' || matrix[newPosY][newPosX] == '0') {
        direction = newDirection;
        // if (b.contains(
        //     XYpointWithDirection(positionIntX, positionIntY, direction))) {
        //   stuck = true;
        //   break;
        // }
        // b.add(XYpointWithDirection(positionIntX, positionIntY, direction));
      } else {
        positionIntX = newPosX;
        positionIntY = newPosY;
        if (b.contains(
            XYpointWithDirection(positionIntX, positionIntY, direction))) {
          stuck = true;
          break;
        }
        b.add(XYpointWithDirection(positionIntX, positionIntY, direction));
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
      if (b.contains(
          XYpointWithDirection(positionIntX, positionIntY, direction))) {
        stuck = true;
        break;
      }
      b.add(XYpointWithDirection(positionIntX, positionIntY, direction));
      break;
    }
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
