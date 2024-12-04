import '../../file_reader.dart';

// The Elf looks quizzically at you. Did you misunderstand the assignment?

// Looking for the instructions, you flip over the word search to find that this isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed to find two MAS in the shape of an X. One way to achieve that is like this:

// M.S
// .A.
// M.S
// Irrelevant characters have again been replaced with . in the above diagram. Within the X, each MAS can be written forwards or backwards.

// Here's the same example from before, but this time all of the X-MASes have been kept instead:

// .M.S......
// ..A..MSMS.
// .M.S.MAA..
// ..A.ASMSM.
// .M.S.M....
// ..........
// S.S.S.S.S.
// .A.A.A.A..
// M.M.M.M.M.
// ..........
// In this example, an X-MAS appears 9 times.

// Flip the word search from the instructions back over to the word search side and try again. How many times does an X-MAS appear?
void main() {
  var listOfString = readFile('lib/days/4/day_4_2.txt');
  var sum = 0;
  var valueToFind = 'MAS';
  var rowCount = listOfString[0].length;
  var columnCount = listOfString.length;

  List<List<String>> matrix = [];
  for (var i in listOfString) {
    matrix.add(i.split(''));
  }

  for (var i = 0; i < columnCount; i++) {
    for (var j = 0; j < rowCount; j++) {
      if (funcToFindVerticalReverseXmas(matrix, i, j, valueToFind)) {
        sum++;
      }
    }
  }

  print(sum);
}

bool funcToFindVerticalReverseXmas(
    List<List<String>> matrix, int row, int col, String valueToFind) {
  if (matrix[row][col] != 'A') {
    return false;
  }
  try {
    if (matrix[row - 1][col - 1] == 'M' &&
        matrix[row + 1][col + 1] == 'S' &&
        matrix[row + 1][col - 1] == 'M' &&
        matrix[row - 1][col + 1] == 'S') {
      return true;
    }
    if (matrix[row - 1][col - 1] == 'S' &&
        matrix[row + 1][col + 1] == 'M' &&
        matrix[row + 1][col - 1] == 'S' &&
        matrix[row - 1][col + 1] == 'M') {
      return true;
    }
    if (matrix[row - 1][col - 1] == 'M' &&
        matrix[row + 1][col + 1] == 'S' &&
        matrix[row + 1][col - 1] == 'S' &&
        matrix[row - 1][col + 1] == 'M') {
      return true;
    }
    if (matrix[row - 1][col - 1] == 'S' &&
        matrix[row + 1][col + 1] == 'M' &&
        matrix[row + 1][col - 1] == 'M' &&
        matrix[row - 1][col + 1] == 'S') {
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}
