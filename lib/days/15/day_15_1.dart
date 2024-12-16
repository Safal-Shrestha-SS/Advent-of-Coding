import 'package:advent_of_coding/file_reader.dart';
// You appear back inside your own mini submarine! Each Historian drives their mini submarine in a different direction; maybe the Chief has his own submarine down here somewhere as well?

// You look up to see a vast school of lanternfish swimming past you. On closer inspection, they seem quite anxious, so you drive your mini submarine over to see if you can help.

// Because lanternfish populations grow rapidly, they need a lot of food, and that food needs to be stored somewhere. That's why these lanternfish have built elaborate warehouse complexes operated by robots!

// These lanternfish seem so anxious because they have lost control of the robot that operates one of their most important warehouses! It is currently running amok, pushing around boxes in the warehouse with no regard for lanternfish logistics or lanternfish inventory management strategies.

// Right now, none of the lanternfish are brave enough to swim up to an unpredictable robot so they could shut it off. However, if you could anticipate the robot's movements, maybe they could find a safe option.

// The lanternfish already have a map of the warehouse and a list of movements the robot will attempt to make (your puzzle input). The problem is that the movements will sometimes fail as boxes are shifted around, making the actual movements of the robot difficult to predict.

// For example:

// ##########
// #..O..O.O#
// #......O.#
// #.OO..O.O#
// #..O@..O.#
// #O#..O...#
// #O..O..O.#
// #.OO.O.OO#
// #....O...#
// ##########

// <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
// vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
// ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
// <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
// ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
// ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
// >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
// <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
// ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
// v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
// As the robot (@) attempts to move, if there are any boxes (O) in the way, the robot will also attempt to push those boxes. However, if this action would cause the robot or a box to move into a wall (#), nothing moves instead, including the robot. The initial positions of these are shown on the map at the top of the document the lanternfish gave you.

// The rest of the document describes the moves (^ for up, v for down, < for left, > for right) that the robot will attempt to make, in order. (The moves form a single giant sequence; they are broken into multiple lines just to make copy-pasting easier. Newlines within the move sequence should be ignored.)

// Here is a smaller example to get started:

// ########
// #..O.O.#
// ##@.O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// <^^>>>vv<v>>v<<
// Were the robot to attempt the given sequence of moves, it would push around the boxes as follows:

// Initial state:
// ########
// #..O.O.#
// ##@.O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move <:
// ########
// #..O.O.#
// ##@.O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move ^:
// ########
// #.@O.O.#
// ##..O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move ^:
// ########
// #.@O.O.#
// ##..O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move >:
// ########
// #..@OO.#
// ##..O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move >:
// ########
// #...@OO#
// ##..O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move >:
// ########
// #...@OO#
// ##..O..#
// #...O..#
// #.#.O..#
// #...O..#
// #......#
// ########

// Move v:
// ########
// #....OO#
// ##..@..#
// #...O..#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move v:
// ########
// #....OO#
// ##..@..#
// #...O..#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move <:
// ########
// #....OO#
// ##.@...#
// #...O..#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move v:
// ########
// #....OO#
// ##.....#
// #..@O..#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move >:
// ########
// #....OO#
// ##.....#
// #...@O.#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move >:
// ########
// #....OO#
// ##.....#
// #....@O#
// #.#.O..#
// #...O..#
// #...O..#
// ########

// Move v:
// ########
// #....OO#
// ##.....#
// #.....O#
// #.#.O@.#
// #...O..#
// #...O..#
// ########

// Move <:
// ########
// #....OO#
// ##.....#
// #.....O#
// #.#O@..#
// #...O..#
// #...O..#
// ########

// Move <:
// ########
// #....OO#
// ##.....#
// #.....O#
// #.#O@..#
// #...O..#
// #...O..#
// ########
// The larger example has many more moves; after the robot has finished those moves, the warehouse would look like this:

// ##########
// #.O.O.OOO#
// #........#
// #OO......#
// #OO@.....#
// #O#.....O#
// #O.....OO#
// #O.....OO#
// #OO....OO#
// ##########
// The lanternfish use their own custom Goods Positioning System (GPS for short) to track the locations of the boxes. The GPS coordinate of a box is equal to 100 times its distance from the top edge of the map plus its distance from the left edge of the map. (This process does not stop at wall tiles; measure all the way to the edges of the map.)

// So, the box shown below has a distance of 1 from the top edge of the map and 4 from the left edge of the map, resulting in a GPS coordinate of 100 * 1 + 4 = 104.

// #######
// #...O..
// #......
// The lanternfish would like to know the sum of all boxes' GPS coordinates after the robot finishes moving. In the larger example, the sum of all boxes' GPS coordinates is 10092. In the smaller example, the sum is 2028.

// Predict the motion of the robot and boxes in the warehouse. After the robot is finished moving, what is the sum of all boxes' GPS coordinates?


void main() {
  var listOfString = readFile('lib/days/15/day_15_1.txt');
  List<List<String>> grid = [];
  List<String> directions = [];
  int breakPoint = 0;

  var robotPosition = (0, 0);
  for (var i = 0; i < listOfString.length; i++) {
    if (listOfString[i].isEmpty) {
      breakPoint = i;
      break;
    }
    grid.add(listOfString[i].split(''));
    if (listOfString[i].contains('@')) {
      robotPosition = (i, listOfString[i].indexOf('@'));
    }
  }
  for (var i = breakPoint + 1; i < listOfString.length; i++) {
    directions.addAll(listOfString[i].split(''));
  }

  for (var i = 0; i < directions.length; i++) {
    var direction = directions[i];
    List<(int, int)> boxes = [];
    var tempPosition = robotPosition;
    var move = false;
    if (direction == '<') {
      while (true) {
        tempPosition = (tempPosition.$1, tempPosition.$2 - 1);
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          boxes.add(tempPosition);
          break;
        }
        boxes.add(tempPosition);
      }
    }
    if (direction == '>') {
      while (true) {
        tempPosition = (tempPosition.$1, tempPosition.$2 + 1);
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          boxes.add(tempPosition);
          break;
        }
        boxes.add(tempPosition);
      }
    }
    if (direction == '^') {
      while (true) {
        tempPosition = (tempPosition.$1 - 1, tempPosition.$2);
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          boxes.add(tempPosition);
          break;
        }
        boxes.add(tempPosition);
      }
    }
    if (direction == 'v') {
      while (true) {
        tempPosition = (tempPosition.$1 + 1, tempPosition.$2);
        if (grid[tempPosition.$1][tempPosition.$2] == '#') {
          move = false;
          break;
        }
        if (grid[tempPosition.$1][tempPosition.$2] == '.') {
          move = true;
          boxes.add(tempPosition);
          break;
        }
        boxes.add(tempPosition);
      }
    }
    if (move) {
      grid[robotPosition.$1][robotPosition.$2] = '.';
      grid[boxes.first.$1][boxes.first.$2] = '@';
      robotPosition = boxes.first;
      for (var i = 1; i < boxes.length; i++) {
        grid[boxes[i].$1][boxes[i].$2] = 'O';
      }
    }
    boxes.clear();
  }

  var sum = 0;
  for (var i = 0; i < grid.length; i++) {
    for (var j = 0; j < grid[0].length; j++) {
      if (grid[i][j] == 'O') {
        sum+=(100*i+j);
      }
    }
  }
  print(sum);
}
