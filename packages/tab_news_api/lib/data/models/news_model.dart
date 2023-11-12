class NewsModel {
  const NewsModel(
    this.id,
    this.ownerId,
    this.parentId,
    this.slug,
    this.title,
    this.status,
    this.sourceUrl,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.deletedAt,
    this.tabcoins,
    this.ownerUsername,
    this.childrenDeepCount,
    this.children,
  );

  final String id;
  final String ownerId;
  final String? parentId;
  final String slug;
  final String title;
  final String status;
  final String? sourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final DateTime? deletedAt;
  final int tabcoins;
  final String ownerUsername;
  final int childrenDeepCount;
  final List<NewsModel>? children;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      json['id'] as String,
      json['owner_id'] as String,
      json['parent_id'] as String?,
      json['slug'] as String,
      json['title'] as String,
      json['status'] as String,
      json['source_url'] as String?,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
      DateTime.parse(json['published_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['tabcoins'] as int,
      json['owner_username'] as String,
      json['children_deep_count'] as int,
      (json['children'] as List<dynamic>?)
          ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'parent_id': parentId,
      'slug': slug,
      'title': title,
      'status': status,
      'source_url': sourceUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'published_at': publishedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'tabcoins': tabcoins,
      'owner_username': ownerUsername,
      'children_deep_count': childrenDeepCount,
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}
