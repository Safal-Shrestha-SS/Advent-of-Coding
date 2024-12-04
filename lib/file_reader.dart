import 'dart:io';

List<String> readFile(String path) {
  try {
    File file = File(path);
    List<String> lines = file.readAsLinesSync();
    return lines;
  } catch (e) {
    print('Error: $e');
    return [];
  }
}