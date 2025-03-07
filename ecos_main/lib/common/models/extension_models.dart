import 'package:ecos_main/common/models/base_models.dart';
import 'package:ecos_main/common/models/user_models.dart';
import 'package:ecos_main/common/enums/extensions_enums.dart';

class Extension extends BaseDataModel {
  const Extension({
    required this.category,
    required this.title,
    required this.iconCode,
    required this.color,
    required this.id,
  });

  final String id;
  final ExtensionCategory category;
  final String title;
  final int iconCode;
  final int color;

  factory Extension.fromJSON(Map<String, dynamic> json) {
    return Extension(
      category: ExtensionCategory.values.firstWhere(
        (e) => e.toString() == 'TodoCategory.${json['category']}',
        orElse: () => ExtensionCategory.productive,
      ),
      title: json['title'],
      iconCode: json['iconCode'],
      color: json['color'],
      id: json['id'],
    );
  }

  @override
  Map<String, dynamic> get toMinJSON => {
        'category': category.toString().split('.').last,
        'title': title,
        'iconCode': iconCode,
        'color': color,
      };

  @override
  Map<String, dynamic> get toJSON => {
        'id': id,
        ...toMinJSON,
      };
}

class ExtensionDetail extends BaseDataModel {
  const ExtensionDetail({
    required this.description,
    required this.comments,
    required this.caption,
    required this.images,
    required this.information,
    required this.meta,
    required this.ratings,
    required this.id,
  });

  final String id;
  final Extension information;
  final String description;
  final String caption;
  final double ratings;

  final List<Comment> comments;
  final List<String> images;
  final Map<String, dynamic> meta;

  factory ExtensionDetail.fromJSON(Map<String, dynamic> json) {
    return ExtensionDetail(
      id: json['id'],
      information: Extension.fromJSON(json['information']),
      description: json['description'],
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJSON(comment))
          .toList(),
      caption: json['caption'],
      images: List<String>.from(json['images']),
      meta: json['meta'],
      ratings: json['ratings'].toDouble(),
    );
  }

  @override
  Map<String, dynamic> get toMinJSON => {
        'information': information.toJSON,
        'description': description,
        'comments': comments.map((comment) => comment.toJSON).toList(),
        'caption': caption,
        'images': images,
        'meta': meta,
        'ratings': ratings,
      };

  @override
  Map<String, dynamic> get toJSON => toMinJSON;
}

class Comment extends BaseDataModel {
  Comment({
    required this.title,
    required this.description,
    required this.createdBy,
    required this.id,
    createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final User createdBy;

  factory Comment.fromJSON(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdBy: User.fromJSON(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> get toMinJSON => {
        'title': title,
        'description': description,
        'createdBy': createdBy.toJSON,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  Map<String, dynamic> get toJSON => toMinJSON;
}
