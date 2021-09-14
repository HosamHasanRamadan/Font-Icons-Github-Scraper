// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';

// Project imports:
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final downloadSvgIcons = Step.define('downloadSvgIcons')
    .dep(prepareWorkingIconsInfo)
    .dep(prepareAllFolder)
    // ignore: top_level_function_literal_block
    .build((fontIcon, fontFolder) {
  fontIcon.gitHubSubfolderLink.download_subfolder(fontFolder.svgPath);
});
