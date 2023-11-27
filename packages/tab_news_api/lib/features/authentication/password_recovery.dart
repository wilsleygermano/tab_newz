import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';

class EmptyParametersFailure implements Exception {
  final String message;

  EmptyParametersFailure(
      {this.message =
          'Você deve informar um e-mail ou nome de usuário válido.'});
}

class PasswordRecoveryRequestFailure implements Exception {
  final String message;

  PasswordRecoveryRequestFailure({required this.message});
}

class LoginResponseNotFound implements Exception {
  final String message;

  LoginResponseNotFound({this.message = 'O servidor não respondeu.'});
}

class PasswordRecovery {
  PasswordRecovery({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<void> passwordRecovery({
    required String email,
    required String username,
  }) async {
    if (email.isEmpty && username.isEmpty) {
      throw EmptyParametersFailure();
    }

    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.recovery);

    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível recuperar a senha.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw PasswordRecoveryRequestFailure(message: error);
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw LoginResponseNotFound();
    }
    return;
  }
}