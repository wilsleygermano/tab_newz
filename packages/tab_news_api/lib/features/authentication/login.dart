import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';
import 'package:tab_news_api/data/model/session_model.dart';

class LoginRequestFailure implements Exception {
  final String message;

  LoginRequestFailure({this.message = 'Não foi possível realizar o login.'});
}

class LoginResponseNotFound implements Exception {
  final String message;

  LoginResponseNotFound({this.message = 'O servidor não respondeu.'});
}

class Login {
  Login({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<SessionModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.sessions);

    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw LoginRequestFailure();
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw LoginResponseNotFound();
    }

    return SessionModel.fromJson(responseMap);
  }
}