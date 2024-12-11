import 'package:advent_of_coding/file_reader.dart';

// The reindeer spends a few minutes reviewing your hiking trail map before realizing something, disappearing for a few minutes, and finally returning with yet another slightly-charred piece of paper.

// The paper describes a second way to measure a trailhead called its rating. A trailhead's rating is the number of distinct hiking trails which begin at that trailhead. For example:

// .....0.
// ..4321.
// ..5..2.
// ..6543.
// ..7..4.
// ..8765.
// ..9....
// The above map has a single trailhead; its rating is 3 because there are exactly three distinct hiking trails which begin at that position:

// .....0.   .....0.   .....0.
// ..4321.   .....1.   .....1.
// ..5....   .....2.   .....2.
// ..6....   ..6543.   .....3.
// ..7....   ..7....   .....4.
// ..8....   ..8....   ..8765.
// ..9....   ..9....   ..9....
// Here is a map containing a single trailhead with rating 13:

// ..90..9
// ...1.98
// ...2..7
// 6543456
// 765.987
// 876....
// 987....
// This map contains a single trailhead with rating 227 (because there are 121 distinct hiking trails that lead to the 9 on the right edge and 106 that lead to the 9 on the bottom edge):

// 012345
// 123456
// 234567
// 345678
// 4.6789
// 56789.
// Here's the larger example from before:

// 89010123
// 78121874
// 87430965
// 96549874
// 45678903
// 32019012
// 01329801
// 10456732
// Considering its trailheads in reading order, they have ratings of 20, 24, 10, 4, 1, 4, 5, 8, and 5. The sum of all trailhead ratings in this larger example topographic map is 81.

// You're not sure how, but the reindeer seems to have crafted some tiny flags out of toothpicks and bits of paper and is using them to mark trailheads on your topographic map. What is the sum of the ratings of all trailheads?
void main() {
  List<String> input = readFile('lib/days/10/day_10_2.txt');
  List<List<int>> grid =
      input.map((row) => row.split('').map(int.parse).toList()).toList();
  var path = 0;
  for (var y = 0; y < grid.length; y++) {
    for (var x = 0; x < grid[y].length; x++) {
      if (grid[y][x] == 0) {
        path += findPath(x, y, 0, grid);
      }
    }
  }
  print(path);
}

List<List<int>> directions = [
  [0, -1],
  [0, 1],
  [-1, 0],
  [1, 0]
];
int findPath(int x, int y, int currentValue, List<List<int>> grid) {
  if (grid[y][x] == 9) {
    return 1;
  }
  int path = 0;
  Set<(int y, int x)> visited = {(y, x)};
  for (var i in directions) {
    var newY = y + i[0];
    var newX = x + i[1];
    if (!(visited.contains((newY, newX))) &&
        newY >= 0 &&
        newY < grid.length &&
        newX >= 0 &&
        newX < grid[0].length &&
        (grid[newY][newX]) == currentValue + 1) {
      path += findPath(newX, newY, currentValue + 1, grid);
    }
  }
  visited.remove((y, x));
  return path;
}
