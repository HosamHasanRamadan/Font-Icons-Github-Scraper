// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';

// Project imports:
import 'prepare_all_folders.dart';
import 'prepare_working_icons_info.dart';

final createIconsFont =
    // ignore: top_level_function_literal_block
    Step.define('Create Icons Font')
        .dep(prepareAllFolder)
        .dep(prepareWorkingIconsInfo)
        // ignore: top_level_function_literal_block
        .build((fontFolder, iconsInfo) {
  iconsInfo.gitHubSubfolderLink.createFontAssets(
    fontFolder.optimizedSvg,
    fontFolder.fontPath,
    iconsInfo.name,
  );
});
