// Project imports:
import 'icons_info.dart';

class FontFolder {
  final IconsInfo iconsInfo;
  final String rootDir;
  String get _fontName => iconsInfo.name;

  String get svgPath => '$rootDir/${_fontName}/svg';
  String get optimizedSvg => '$rootDir/${_fontName}/optimized_svg';
  String get fontPath => '$rootDir/${_fontName}/font';
  String get fontTTF => '$fontPath/$_fontName.ttf';

  String get jsonOutput => '$fontPath/${iconsInfo.name}.json';

  String get rootJsonOutput =>
      '$rootDir/${iconsInfo.name}/${iconsInfo.name}.json';
  FontFolder(this.iconsInfo, this.rootDir);
}
