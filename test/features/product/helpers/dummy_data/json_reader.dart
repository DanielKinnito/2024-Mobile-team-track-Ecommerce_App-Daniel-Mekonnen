import 'dart:io';

String readJson(String fileName) {
  final directory = Directory.current.path;
  final path = '$directory/test/helpers/dummy_data/$fileName';
  print(path);
  return File(path).readAsStringSync();
}
