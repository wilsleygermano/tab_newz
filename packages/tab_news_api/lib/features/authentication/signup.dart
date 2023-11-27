import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';
import 'package:tab_news_api/data/model/user_model.dart';

class SignupFailure implements Exception {
  final String message;

  SignupFailure({required this.message});
}

class SingupResponseNotFound implements Exception {
  final String message;

  SingupResponseNotFound({this.message = 'O servidor não respondeu.'});
}

class SignUp {
  SignUp({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<UserModel> call({
    required String email,
    required String password,
    required String username,
  }) async {
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.users);

    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível realizar o cadastro.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw SignupFailure(message: error);
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw SingupResponseNotFound();
    }

    return UserModel.fromJson(responseMap);
  }
}
