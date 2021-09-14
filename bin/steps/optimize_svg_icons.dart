// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final optimizeSvgIcons = Step.define('Flatten Sub Folder')
    .dep(prepareAllFolder)
    .dep(prepareWorkingIconsInfo)
    // ignore: top_level_function_literal_block
    .build((fontFolder, iconsInfo) {
  copyTree(fontFolder.svgPath, fontFolder.optimizedSvg);

  if (iconsInfo.needsOptimization) optimizeSvgs(fontFolder.optimizedSvg);
});

bool optimizeSvgs(String path) {
  try {
    [
      ' flatpak run org.inkscape.Inkscape',
      '--verb="EditSelectAll;SelectionUnGroup;StrokeToPath;SelectionUnion;SelectionCombine;FitCanvasToSelection;FileVacuum;FileSave;FileClose"',
      '--with-gui',
      '--batch-process',
      '*.svg'
    ].join(' ').start(workingDirectory: path);
    return true;
  } on Exception {
    return false;
  }
}
