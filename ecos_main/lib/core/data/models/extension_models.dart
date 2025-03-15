import 'package:ecos_main/shared/lib/models/base_models.dart';
import 'package:ecos_main/features/auth/lib/models/user_models.dart';
import 'package:ecos_main/core/constants/enums/extensions_enums.dart';

class Extension extends BaseDataModel {
  const Extension({
    required this.category,
    required this.title,
    required this.iconCode,
    required this.color,
    required this.id,
    required this.meta,
  });

  final String id;
  final ExtensionCategory category;
  final String title;
  final int iconCode;
  final int color;
  final ExtensionMeta meta;

  factory Extension.fromJSON(Map<String, dynamic> json) {
    return Extension(
      category: ExtensionCategory.values.firstWhere(
        (e) => e.toString() == 'ExtensionCategory.${json['category']}',
        orElse: () => ExtensionCategory.productive,
      ),
      title: json['title'],
      iconCode: json['iconCode'],
      color: json['color'],
      id: json['id'],
      meta: ExtensionMeta.fromJSON(json['meta']),
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
        'meta': meta.toJSON,
      };
}

class ExtensionDetail extends BaseDataModel {
  const ExtensionDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.iconCode,
    required this.color,
    required this.description,
    required this.comments,
    required this.caption,
    required this.images,
    required this.meta,
    required this.ratings,
    required this.totalCommentsCount,
    this.similarExtensions = const [],
  });

  final String id;
  final ExtensionCategory category;
  final String title;
  final int iconCode;
  final int color;
  final String description;
  final String caption;
  final double ratings;
  final int totalCommentsCount;

  final List<Comment> comments;
  final List<String> images;
  final ExtensionMeta meta;
  final List<Extension> similarExtensions;

  factory ExtensionDetail.fromJSON(Map<String, dynamic> json) {
    return ExtensionDetail(
      id: json['id'],
      category: ExtensionCategory.values.firstWhere(
        (e) => e.toString() == 'ExtensionCategory.${json['category']}',
        orElse: () => ExtensionCategory.productive,
      ),
      title: json['title'],
      iconCode: json['iconCode'],
      color: json['color'],
      description: json['description'],
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJSON(comment))
          .toList(),
      caption: json['caption'],
      images: List<String>.from(json['images']),
      meta: ExtensionMeta.fromJSON(json['meta']),
      ratings: json['ratings'].toDouble(),
      totalCommentsCount: json['comments'].length,
      similarExtensions: (json['similarExtensions'] as List)
          .map((ext) => Extension.fromJSON(ext))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> get toMinJSON => {
        'id': id,
        'category': category.toString().split('.').last,
        'title': title,
        'iconCode': iconCode,
        'color': color,
        'description': description,
        'caption': caption,
        'totalCommentsCount': totalCommentsCount,
        'ratings': ratings,
      };

  @override
  Map<String, dynamic> get toJSON => {
        'comments': comments.map((comment) => comment.toJSON).toList(),
        'images': images,
        'meta': meta.toJSON,
        ...toMinJSON,
        'relatedExtensions':
            similarExtensions.map((ext) => ext.toJSON).toList(),
      };
}

class ExtensionMeta extends BaseDataModel {
  const ExtensionMeta({
    required this.ageRequired,
    required this.needSubscription,
    required this.isDownload,
    required this.rankInTheCategory,
  });

  factory ExtensionMeta.fromJSON(Map<String, dynamic> json) {
    return ExtensionMeta(
      ageRequired: json['ageRequired'] ?? '18+',
      needSubscription: json['needSubscription'] ?? false,
      isDownload: json['isDownload'] ?? false,
      rankInTheCategory: json['rankInTheCategory'] ?? '1',
    );
  }

  final String ageRequired;
  final bool needSubscription;
  final bool isDownload; // For Android OS
  final String rankInTheCategory;

  @override
  Map<String, dynamic> get toMinJSON => {
        'ageRequired': ageRequired,
        'needSubscription': needSubscription,
        'isDownload': isDownload,
        'rankInTheCategory': rankInTheCategory,
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
    required this.rating,
    createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  final String title;
  final double rating;
  final String description;
  final DateTime createdAt;
  final User createdBy;

  factory Comment.fromJSON(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      title: json['title'],
      rating: json['rating'].toDouble(),
      description: json['description'],
      createdBy: User.fromJSON(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> get toMinJSON => {
        'title': title,
        'description': description,
        'rating': rating,
        'createdBy': createdBy.toJSON,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  Map<String, dynamic> get toJSON => toMinJSON;
}
