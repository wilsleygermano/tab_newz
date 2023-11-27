import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';

enum PublishStatus { published, deleted, draft }

class PublishFailure implements Exception {
  final String message;

  PublishFailure({required this.message});
}

class Publish {
  Publish({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<void> call({
    required String title,
    required String body,
    required String sessionId,
    required PublishStatus status,
  }) async {
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.contents);

    String statusString;

    switch (status) {
      case PublishStatus.published:
        statusString = "published";
        break;
      case PublishStatus.deleted:
        statusString = "deleted";
        break;
      case PublishStatus.draft:
        statusString = "draft";
        break;
    }

    var response = await _httpClient.post(
      url,
      headers: {
        "session_id": sessionId,
      },
      body: {
        'title': title,
        'body': body,
        'status': statusString,
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível publicar seu conteúdo.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw PublishFailure(message: error);
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw PublishFailure(message: "O servidor não respondeu.");
    }

    return;
  }
}
