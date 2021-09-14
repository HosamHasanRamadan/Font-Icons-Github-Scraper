// ignore: top_level_function_literal_block

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final cleanUp = Step.define('Create Global Json File')
    .dep(prepareAllFolder)
    .dep(prepareWorkingIconsInfo)
    // ignore: top_level_function_literal_block
    .build((fontFolder, iconsInfo) {
  deleteDir(fontFolder.optimizedSvg);
  delete(fontFolder.jsonOutput);
});
