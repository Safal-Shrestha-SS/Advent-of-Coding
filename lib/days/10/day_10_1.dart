import 'package:advent_of_coding/file_reader.dart';
import 'package:dart_console/dart_console.dart';

void main() {
  var listOfString = readFile('lib/days/10/day_10_2.txt');
  List<List<String>> matrix = [];
  for (var i = 0; i < listOfString.length; i++) {
    matrix.add(listOfString[i].split(''));
  }
  var horizontalLengeth = matrix[0].length;
  var verticalLength = matrix.length;

  List<List<int>> wayMatrix = [
    [0, -1],
    [1, 0],
    [0, 1],
    [-1, 0]
  ];
  print(matrix);
  int sum = 0;
  Set<(int a, int b)> uniqueDestination = {};
  for (var i = 0; i < verticalLength; i++) {
    for (var j = 0; j < horizontalLengeth; j++) {
      if (matrix[i][j] == '0') {
        List<({int x, int y})> possiblePaths = [(x: j, y: i)];
        uniqueDestination.clear();
        while (possiblePaths.isNotEmpty) {
          var lengthToTraverse = possiblePaths.length;
          var (x: a, y: b) = possiblePaths.removeAt(0);
          for (var k = 0; k < lengthToTraverse; k++) {
            {
              for (var l = 0; l < wayMatrix.length; l++) {
                try {
                  var newX = a + wayMatrix[l][0];
                  var newY = b + wayMatrix[l][1];
                  if (int.parse(matrix[newY][newX]) !=
                      (int.parse(matrix[b][a]) + 1)) {
                    continue;
                  }
                  if (matrix[newY][newX] == '9') {
                    uniqueDestination.add((newX, newY));
                    continue;
                  } else {
                    var a = generateMatrixOfLength(
                        horizontalLengeth, verticalLength);
                    a[newY][newX] = matrix[newY][newX];
                    printMatrix(a);
                    if (possiblePaths.contains((x: newX, y: newY))) {
                      continue;
                    }
                    possiblePaths.add((x: newX, y: newY));
                  }
                } catch (e) {
                  continue;
                }
              }
            }
          }
        }
        sum += uniqueDestination.length;
      }
    }
  }

  print(uniqueDestination);
  print(sum);
}

void printMatrix(List<List<String>> matrix) {
  Console().clearScreen();
  for (var i = 0; i < matrix.length; i++) {
    print('$i: ${matrix[i]}');
  }
}

List<List<String>> generateMatrixOfLength(
    int horizontalLengeth, int verticalLength) {
  List<List<String>> matrix = [];
  for (var i = 0; i < verticalLength; i++) {
    List<String> row = [];
    for (var j = 0; j < horizontalLengeth; j++) {
      row.add('.');
    }
    matrix.add(row);
  }
  return matrix;
}
