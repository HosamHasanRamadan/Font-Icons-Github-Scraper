// ignore: top_level_function_literal_block

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import '../data/font_folder.dart';
import 'constants.dart';
import 'prepare_working_icons_info.dart';

final prepareAllFolder =
    Step.define('prepare folder').dep(prepareWorkingIconsInfo)
        // ignore: top_level_function_literal_block
        .build((iconsInfo) {
  final fontFolder = FontFolder(iconsInfo, rootFolder);
  print('prepareing folders for ${iconsInfo.name} ....');

  [
    fontFolder.svgPath,
    fontFolder.optimizedSvg,
    fontFolder.fontPath,
  ].forEach((path) => createDir(path, recursive: true));

  print('prepareing folders for ${iconsInfo.name} .... ✅');
  return fontFolder;
});
