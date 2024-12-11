import 'package:advent_of_coding/file_reader.dart';

// Upon completion, two things immediately become clear. First, the disk definitely has a lot more contiguous free space, just like the amphipod hoped. Second, the computer is running much more slowly! Maybe introducing all of that file system fragmentation was a bad idea?

// The eager amphipod already has a new plan: rather than move individual blocks, he'd like to try compacting the files on his disk by moving whole files instead.

// This time, attempt to move whole files to the leftmost span of free space blocks that could fit the file. Attempt to move each file exactly once in order of decreasing file ID number starting with the file with the highest file ID number. If there is no span of free space to the left of a file that is large enough to fit the file, the file does not move.

// The first example from above now proceeds differently:

// 00...111...2...333.44.5555.6666.777.888899
// 0099.111...2...333.44.5555.6666.777.8888..
// 0099.1117772...333.44.5555.6666.....8888..
// 0099.111777244.333....5555.6666.....8888..
// 00992111777.44.333....5555.6666.....8888..
// The process of updating the filesystem checksum is the same; now, this example's checksum would be 2858.

// Start over, now compacting the amphipod's hard drive using this new method instead. What is the resulting filesystem checksum?
void main() {
  var listOfString = readFile('lib/days/9/day_9_2.txt');
  List<String> givenCode = listOfString[0].split('');
  List<(int id, int value)> dotIds = [];
  Map<int, (int id, int value)> files = {};
  int fid = 0;
  int pos = 0;
  for (var entry in givenCode.asMap().entries) {
    int i = entry.key;
    int x = int.parse(entry.value);
    if (i % 2 == 0) {
      files[fid] = (pos, x);
      fid += 1;
    } else {
      if ((x != 0)) dotIds.add((pos, x));
    }
    pos += x;
  }
  print(files);

  while (fid > 0) {
    fid -= 1;
    var (pos, size) = files[fid]!;
    for (var entry in dotIds.asMap().entries) {
      int i = entry.key;
      var (start, length) = entry.value;
      if (start >= pos) {
        dotIds = dotIds.sublist(0,i);
        break;
      }
      if (size == length) {
        files[fid] = (start, size);
        dotIds.remove(entry.value);
        break;
      }
      if (size < length) {
        files[fid] = (start, size);
        dotIds[i] = (start + size, length - size);
        break;
      }
    }
  }
  int total =0;
  for(var entry in files.entries) {
    int i = entry.key;
    var (pos, size) = entry.value;
    for(int x = pos; x < pos + size; x++) {
      total += i * x;
    }
  }
  print(total);
}

