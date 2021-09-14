// ignore: top_level_function_literal_block

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import 'constants.dart';

// ignore: top_level_function_literal_block
final createGlobalJsonFile = Step.define('Create Global Json File').build(() {
  final globlaJsonFilePath = '$rootFolder/$globalJsonFileName';
  touch(globlaJsonFilePath, create: true);
  final globalJsonFile = File(globlaJsonFilePath);
  // initlaizse json file with empty list
  globalJsonFile.writeAsStringSync('[]');
});
