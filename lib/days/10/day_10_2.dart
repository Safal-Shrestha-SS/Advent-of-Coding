import 'package:advent_of_coding/file_reader.dart';
import 'package:dart_console/dart_console.dart';

void main() {
  List<String> input = readFile('lib/days/10/day_10_2.txt');
  List<List<int>> grid =
      input.map((row) => row.split('').map(int.parse).toList()).toList();

  int rows = grid.length;
  int cols = grid[0].length;

  List<List<int>> directions = [
    [0, -1],
    [0, 1],
    [-1, 0],
    [1, 0]
  ];

  int findPaths(int x, int y, int currentValue, List<List<bool>> visited) {
    if (grid[y][x] == 9) return 1;

    visited[y][x] = true;

    int pathCount = 0;

    for (var dir in directions) {
      int newX = x + dir[0];
      int newY = y + dir[1];

      if (newX >= 0 && newY >= 0 && newX < cols && newY < rows) {
        if (!visited[newY][newX] && grid[newY][newX] == currentValue + 1) {
          print(visited);
          pathCount += findPaths(newX, newY, grid[newY][newX], visited);
        }
      }
    }
    visited[y][x] = false;

    return pathCount;
  }

  int totalPaths = 0;

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      if (grid[y][x] == 0) {
        List<List<bool>> visited =
            List.generate(rows, (_) => List.generate(cols, (_) => false));
        var a = findPaths(x, y, 0, visited);
        totalPaths += a;
      }
    }
  }

  print("Total unique paths: $totalPaths");
}

// void printMatrix(List<List<String>> matrix) {
//   // return;
//   Console().clearScreen();
//   for (var i = 0; i < matrix.length; i++) {
//     print('$i: ${matrix[i]}');
//   }
// }

// List<List<String>> generateMatrixOfLength(
//     int horizontalLengeth, int verticalLength) {
//   List<List<String>> matrix = [];
//   for (var i = 0; i < verticalLength; i++) {
//     List<String> row = [];
//     for (var j = 0; j < horizontalLengeth; j++) {
//       row.add('.');
//     }
//     matrix.add(row);
//   }
//   return matrix;
// }

// import 'package:advent_of_coding/file_reader.dart';
// import 'package:dart_console/dart_console.dart';

// void main() {
//   var listOfString = readFile('lib/days/10/day_10_2.txt');
//   List<List<String>> matrix = [];
//   for (var i = 0; i < listOfString.length; i++) {
//     matrix.add(listOfString[i].split(''));
//   }
//   var horizontalLengeth = matrix[0].length;
//   var verticalLength = matrix.length;

//   List<List<int>> wayMatrix = [
//     [0, -1],
//     [1, 0],
//     [0, 1],
//     [-1, 0]
//   ];
//   var hjjhjh = generateMatrixOfLength(horizontalLengeth, verticalLength);
//   print(matrix);
//   int sum = 0;
//   int trail = 0;
//   Map<(int a, int b), int> seen = {};
//   Set<(int a, int b)> uniqueDestination = {};
//   for (var i = 0; i < verticalLength; i++) {
//     for (var j = 0; j < horizontalLengeth; j++) {
//       if (matrix[i][j] == '0') {
//         seen.clear();
//         List<({int x, int y})> possiblePaths = [(x: j, y: i)];
//         seen[(j, i)] = 1;
//         uniqueDestination.clear();
//         while (possiblePaths.isNotEmpty) {
//           var lengthToTraverse = possiblePaths.length;
//           var (x: a, y: b) = possiblePaths.removeAt(0);
//           if (matrix[b][a] == '9') {
//             trail += seen[(a, b)]!;
//             break;
//           }
//           for (var k = 0; k < lengthToTraverse; k++) {
//             {
//               for (var l = 0; l < wayMatrix.length; l++) {
//                 try {
//                   var newX = a + wayMatrix[l][0];
//                   var newY = b + wayMatrix[l][1];
//                   if (int.parse(matrix[newY][newX]) !=
//                       (int.parse(matrix[b][a]) + 1)) {
//                     continue;
//                   }
//                   if (seen[(newX, newY)] != null) {
//                     seen[(newX, newY)] = seen[(newX, newY)]! + seen[(a, b)]!;
//                     continue;
//                   } else {
//                     seen[(newX, newY)] = seen[(a, b)]!;
//                   }
//                   if (possiblePaths.contains((x: newX, y: newY))) {
//                     continue;
//                   }
//                   hjjhjh[newY][newX] = seen[(newX, newY)].toString();
//                   printMatrix(hjjhjh);
//                   // print('uniqueDestination:$newX , $newY  ${seen[(
//                   //   newX,
//                   //   newY
//                   // )]}');
//                   possiblePaths.add((x: newX, y: newY));
//                 } catch (e) {
//                   continue;
//                 }
//               }
//             }
//           }
//         }
//         // print(seen);
//         sum += uniqueDestination.length;
//       }
//     }
//   }
//   print(trail);
//   print(sum);
// }

void printMatrix(List<List<String>> matrix) {
  // return;
  Console().clearScreen();
  for (var i = 0; i < matrix.length; i++) {
    print('${matrix[i]}\n');
  }
}

// List<List<String>> generateMatrixOfLength(
//     int horizontalLengeth, int verticalLength) {
//   List<List<String>> matrix = [];
//   for (var i = 0; i < verticalLength; i++) {
//     List<String> row = [];
//     for (var j = 0; j < horizontalLengeth; j++) {
//       row.add('.');
//     }
//     matrix.add(row);
//   }
//   return matrix;
// }
