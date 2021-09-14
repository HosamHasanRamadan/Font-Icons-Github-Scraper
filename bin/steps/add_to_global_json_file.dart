// ignore: top_level_function_literal_block

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';

// Project imports:
import '../main.dart';
import 'constants.dart';
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final addToGlobalJsonFile = Step.define('Add To Global Json File')
    .dep(prepareAllFolder)
    .dep(prepareWorkingIconsInfo)
    .dep(prepareMainRepo)
    // ignore: top_level_function_literal_block
    .build((fontFolder, iconsInfo, mainRepo) async {
  final globalJsonFilePath = '$rootFolder/$globalJsonFileName';
  final globalJsonFile = File(globalJsonFilePath);
  // initlaizse json file with empty list
  final globalJson =
      await jsonDecode(globalJsonFile.readAsStringSync()) as List;
  globalJson.add({
    'name': iconsInfo.name,
    'image_url': iconsInfo.image,
    'repo_url': iconsInfo.gitHubSubfolderLink.repoLink,
    'font_url':
        mainRepo.createRawLink('${iconsInfo.name}/font/${iconsInfo.name}.ttf'),
    'icons_font_url':
        mainRepo.createRawLink("${iconsInfo.name}/${iconsInfo.name}.json")
  });

  globalJsonFile.writeAsStringSync(jsonEncode(globalJson));
});
