import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';

enum VotingStatus { upVote, downVote }

class VotingFailure implements Exception {
  final String message;

  VotingFailure({required this.message});
}

class Voting {
  Voting({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<void> call({
    required String sessionId,
    required String authorId,
    required String newsSlug,
    required VotingStatus status,
  }) async {
    var url = Uri.https(ApiRoutes.baseUrl,
        "${ApiRoutes.contents}/$authorId/$newsSlug/${ApiRoutes.tabcoins}");

    String statusString;

    switch (status) {
      case VotingStatus.upVote:
        statusString = "credit";
        break;
      case VotingStatus.downVote:
        statusString = "debit";
        break;
    }

    var response = await _httpClient.post(
      url,
      headers: {
        "session_id": sessionId,
      },
      body: {
        "transaction_type": statusString,
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível votar.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw VotingFailure(message: error);
    }
    return;
  }
}
