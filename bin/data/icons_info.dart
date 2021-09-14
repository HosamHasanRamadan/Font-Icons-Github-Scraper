// Package imports:
import 'package:dart_json_mapper/dart_json_mapper.dart';

// Project imports:
import 'github_subfolder_link.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, processAnnotatedMembersOnly: false)
class IconsInfo {
  final String name;
  final String image;
  final bool isRecursive;

  final Uri subfolderLink;
  final bool needsOptimization;

  @JsonProperty(ignore: true)
  late final GitHubSubfolderLink gitHubSubfolderLink;

  IconsInfo({
    required this.name,
    required this.image,
    required this.subfolderLink,
    required this.needsOptimization,
    required this.isRecursive,
  }) {
    gitHubSubfolderLink = GitHubSubfolderLink(subfolderLink);
  }
}
