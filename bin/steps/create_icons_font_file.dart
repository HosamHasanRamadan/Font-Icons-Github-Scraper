// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import '../main.dart';
import 'list_all_svg_files.dart';
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final createIconsFontJsonFile = Step.define("Create FOnt Icons Json File")
    .dep(prepareAllFolder)
    .dep(prepareWorkingIconsInfo)
    .dep(prepareMainRepo)
    .dep(listAllSvgFiles)
    // ignore: top_level_function_literal_block
    .build((fontFolder, iconsInfo, mainRepo, allSvgFiles) {
  final buffer = StringBuffer('');
  read(fontFolder.jsonOutput).forEach(buffer.writeln);

  final generatedJsonOutput =
      (jsonDecode(buffer.toString()) as Map).cast<String, int>();

  final iconsFontJson = {
    'repo_url': iconsInfo.gitHubSubfolderLink.repoLink,
    'font_url':
        mainRepo.createRawLink('${iconsInfo.name}/font/${iconsInfo.name}.ttf'),
    'font_family': iconsInfo.name,
    'icons': []
  };

  var filesNames = <String, String>{};
  if (iconsInfo.isRecursive)
    allSvgFiles.forEach((e) => filesNames[e.replaceAll('/', '-')] = e);

  generatedJsonOutput.forEach((name, codepoint) {
    var svgIconPath = '$name.svg';
    if (iconsInfo.isRecursive) {
      svgIconPath = (filesNames['$name.svg'] ?? '');
    }
    (iconsFontJson['icons'] as List).add({
      'name': name,
      'codepoint': codepoint,
      'original_svg_url': iconsInfo.gitHubSubfolderLink.createRawLink(
          '${iconsInfo.gitHubSubfolderLink.subfolderPath}/$svgIconPath'),
      'svg_url': mainRepo.createRawLink('${iconsInfo.name}/svg/$name.svg'),
    });
  });

  touch(fontFolder.rootJsonOutput, create: true);
  final file = File(fontFolder.rootJsonOutput);
  file.writeAsStringSync(jsonEncode(iconsFontJson));
});
