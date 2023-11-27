class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.description,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
    required this.tabCoins,
    required this.tabCash,
  });

  final String id;
  final String username;
  final String description;
  final List<String> features;
  final String createdAt;
  final String updatedAt;
  final int tabCoins;
  final int tabCash;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      description: json['description'] ?? "",
      features: json['features'] != null
          ? (json['features'] as List<dynamic>).map((e) => e as String).toList()
          : [],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      tabCoins: json['tabcoins'] ?? 0,
      tabCash: json['tabcash'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'description': description,
      'features': features,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'tabcoins': tabCoins,
      'tabcash': tabCash,
    };
  }
}
