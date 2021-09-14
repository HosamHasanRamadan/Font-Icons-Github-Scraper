// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';

// Project imports:
import 'prepare_working_icons_info.dart';

// ignore: top_level_function_literal_block
final listAllSvgFiles =
    Step.define('list All Svg Files').dep(prepareWorkingIconsInfo)
        // ignore: top_level_function_literal_block
        .build((iconInfo) {
  final list = iconInfo.gitHubSubfolderLink.listAllSvgFiles();
  return list;
});
