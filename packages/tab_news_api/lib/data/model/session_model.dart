class SessionModel {
  const SessionModel({
    required this.id,
    required this.token,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String token;
  final String expiresAt;
  final String createdAt;
  final String updatedAt;

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        id: json['id'] as String,
        token: json['token'] as String,
        expiresAt: json['expires_at'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'expires_at': expiresAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
