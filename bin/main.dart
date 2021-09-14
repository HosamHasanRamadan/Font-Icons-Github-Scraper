// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:acyclic_steps/acyclic_steps.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dcli/dcli.dart';

// Project imports:
import 'data/data.dart';
import 'data/icons_info.dart';
import 'main.mapper.g.dart';
import 'steps/steps.dart';

Future<T> wrapStepWithLogging<T>(
  Step<T> step,
  Future<T> Function() runStep,
) async {
  print('Starting to run ${step.name}');
  try {
    return await runStep();
  } on Exception catch (e) {
    print(e.toString());
    dynamic a = Future<Null>.value(null);
    return a;
  } finally {
    print('Finishing running ${step.name}');
  }
}

void main(List<String> args) async {
  initializeJsonMapper();

  final r = Runner();
  await r.run(setUp);
  await r.run(createGlobalJsonFile);

  final iconsInfo = getListOfIconInfo();

  for (final i in iconsInfo) {
    final runner = Runner(wrapRunStep: wrapStepWithLogging);
    runner.override(prepareWorkingIconsInfo, i);
    await runner.run(prepareMainRepo);

    await runner.run(listAllSvgFiles);
    await runner.run(prepareAllFolder);
    await runner.run(downloadSvgIcons);
    await runner.run(flattenSubFolders);
    await runner.run(optimizeSvgIcons);
    await runner.run(createIconsFont);
    await runner.run(createIconsFontJsonFile);
    await runner.run(addToGlobalJsonFile);
    await runner.run(cleanUp);
  }
}

// ignore: top_level_function_literal_block
final prepareMainRepo = Step.define('Prepare Main Repo').build(() {
  final repoLink = "https://github.com/HosamHasanRamadan/icons_fonts/tree/main";

  return GitHubSubfolderLink(Uri.parse(repoLink));
});

// ignore: top_level_function_literal_block
final setUp = Step.define('set up').dep(clean).build((_) {
  print('setting up ....');
  createDir('tmp');
  print('setting up done ✅');
});

// ignore: top_level_function_literal_block
final clean = Step.define('clean').build(() {
  print('cleaning...');
  if (isDirectory('tmp')) deleteDir('tmp');
  print('cleaning done ✅');
});

List<IconsInfo> getListOfIconInfo() {
  final jsonString = withOpenFile('icons_srcs.json', (file) {
    final stringBuffer = StringBuffer();
    file.read((line) {
      stringBuffer.writeln(line);
      return true;
    });
    return stringBuffer.toString();
  }, fileMode: FileMode.read);

  final iconsInfo = jsonDecode(jsonString) as List;

  return iconsInfo
      .cast<Map<String, dynamic>>()
      .map((map) => JsonMapper.fromMap<IconsInfo>(map)!)
      .toList();
}
