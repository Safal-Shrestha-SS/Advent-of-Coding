import '../../file_reader.dart';


// As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

// This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:


// ..X...
// .SAMX.
// .A..A.
// XMAS.S
// .X....
// The actual word search will be full of letters instead. For example:

// MMMSXXMASM
// MSAMXMSMSA
// AMXSXMAAMM
// MSAMASMSMX
// XMASAMXAMM
// XXAMMXXAMA
// SMSMSASXSS
// SAXAMASAAA
// MAMMMXMMMM
// MXMXAXMASX
// In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

// ....XXMAS.
// .SAMXMS...
// ...S..A...
// ..A.A.MS.X
// XMASAMX.MM
// X.....XA.A
// S.S.S.S.SS
// .A.A.A.A.A
// ..M.M.M.MM
// .X.X.XMASX
// Take a look at the little Elf's word search. How many times does XMAS appear?
void main() {
  var listOfString = readFile('lib/days/4/day_4_1.txt');
  var sum = 0;
  var valueToFind = 'XMAS';
  var rowCount = listOfString[0].length;
  var columnCount = listOfString.length;
  

  List<List<String>> matrix = [];
  for (var i in listOfString) {
    matrix.add(i.split(''));
  }

  for (var i = 0; i < columnCount; i++) {
    for (var j = 0; j < rowCount; j++) {
      if (funcToFindHorizontailXmas(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (funcToFindHorizontalReverseXmas(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (funcToFindVerticalXmas(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (funcToFindVerticalReverseXmas(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (functoFindDiagonalDownRight(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (FunctoFindDiagonalUpRight(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (funcToFindDiagonalDownnLeft(matrix, i, j, valueToFind)) {
        sum++;
      }
      if (funcToFindDiagonalUpLeft(matrix, i, j, valueToFind)) {
        sum++;
      }
    }
  }

  print(sum);
}

bool functoFindDiagonalDownRight(
    List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row + i < 0 || col + i < 0) {
      break;
    }
    if (row + i > matrix.length - 1 || col + i > matrix[0].length - 1) {
      break;
    }

    if (matrix[row + i][col + i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool FunctoFindDiagonalUpRight(
    List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row - i < 0 || col + i < 0) {
      break;
    }
    if (row - i > matrix.length - 1 || col + i > matrix[0].length - 1) {
      break;
    }
    if (matrix[row - i][col + i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool funcToFindDiagonalDownnLeft(
    List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row + i < 0 || col - i < 0) {
      break;
    }
    if (row + i > matrix.length - 1 || col - i > matrix[0].length - 1) {
      break;
    }
    if (matrix[row + i][col - i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool funcToFindDiagonalUpLeft(
    List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row - i < 0 || col - i < 0) {
      break;
    }
    if (row - i > matrix.length - 1 || col - i > matrix[0].length - 1) {
      break;
    }
    if (matrix[row - i][col - i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}


bool funcToFindHorizontailXmas(List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row < 0 || col + i < 0) {
      break;
    }
    if (row > matrix.length - 1 || col + i > matrix[0].length - 1) {
      break;
    }
    if (matrix[row ][col + i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool funcToFindHorizontalReverseXmas(List<List<String>> matrix, int row, int col, String valueToFind) {
   var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row < 0 || col - i < 0) {
      break;
    }
    if (row > matrix.length - 1 || col - i > matrix[0].length - 1) {
      break;
    }
    if (matrix[row ][col - i] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool funcToFindVerticalXmas(List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row + i < 0 || col < 0) {
      break;
    }
    if (row + i > matrix.length - 1 || col > matrix[0].length - 1) {
      break;
    }
    if (matrix[row + i][col] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}

bool funcToFindVerticalReverseXmas(List<List<String>> matrix, int row, int col, String valueToFind) {
  var foundIndex = 0;
  for (var i = 0; i <= 4; i++) {
    if (row - i < 0 || col < 0) {
      break;
    }
    if (row - i > matrix.length - 1 || col > matrix[0].length - 1) {
      break;
    }
    if (matrix[row - i][col] == valueToFind.split('')[foundIndex]) {
      foundIndex++;
      if (foundIndex == valueToFind.length) {
        return true;
      }
    } else {
      foundIndex = 0;
      break;
    }
  }
  return false;
}