// Package imports:
import 'package:dcli/src/util/string_as_process.dart';
import 'package:recase/recase.dart';

class GitHubSubfolderLink {
  final Uri _uri;

  GitHubSubfolderLink(this._uri);

  String get repoLink => '${_uri.scheme}://${_uri.host}/$repoAuther/$repoName';
  String get repoAuther => _uri.pathSegments[0];
  String get repoName => _uri.pathSegments[1];
  String get branch => _uri.pathSegments[3];
  String get subfolderPath => _uri.pathSegments.sublist(4).join('/');

  String createRawLink(String filePath) => [
        'https://raw.githubusercontent.com',
        repoAuther,
        repoName,
        branch,
        filePath
      ].join('/');

  Iterable<String> listAllSvgFiles() {
    final link = '$repoLink/trunk/$subfolderPath';

    final output = <String>[];
    [
      'svn',
      'ls',
      '-R',
      '--search="*.svg"',
      link,
    ].join(' ').forEach(output.add);
    return output;
  }

  bool download_subfolder(String outDirectory) {
    final link = '$repoLink/trunk/$subfolderPath';
    try {
      'svn export $link $outDirectory --force'.run;
      return true;
    } on Exception {
      return false;
    }
  }

  bool createFontAssets(
      String svgsDirectory, String outDirectory, String fontFamilyName) {
    try {
      [
        'fantasticon',
        svgsDirectory,
        '--name ${fontFamilyName.snakeCase}',
        '--output $outDirectory',
        '--font-types ttf',
        '--asset-types json',
      ].join(' ').run;
      return true;
    } on Exception {
      return false;
    }
  }
}
