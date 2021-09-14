// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final flattenSubFolders = Step.define('Flattern Sub Folder')
    .dep(prepareAllFolder)
    .dep(prepareWorkingIconsInfo)
    .build(
        // ignore: top_level_function_literal_block
        (fontFolder, iconsInfo) {
  if (iconsInfo.isRecursive == false) return;
  // flatten all folders
  find('*.svg', workingDirectory: fontFolder.svgPath).forEach((element) {
    final relativeSvgPath = relative(element, from: fontFolder.svgPath);
    move(
      element,
      fontFolder.svgPath + '/' + relativeSvgPath.replaceAll('/', '-'),
    );
  });

  // clean all subfolders
  ('find ${fontFolder.svgPath} -mindepth 1 -maxdepth 1 -type d' | 'xargs rm -r')
      .run;

  // clean all non svg files
  'find . -type f ! -name "*.svg" -delete'
      .start(workingDirectory: fontFolder.svgPath);
});
