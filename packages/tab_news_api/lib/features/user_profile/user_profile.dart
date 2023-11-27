import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tab_news_api/constants/api_routes.dart';
import 'package:tab_news_api/data/model/models.dart';

class ProfileFailure implements Exception {
  final String message;

  ProfileFailure({required this.message});
}

class UserProfile {
  UserProfile({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<UserModel> getUserProfile({required String sessionId}) async {
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.user);

    var response = await _httpClient.get(
      url,
      headers: {
        "session_id": sessionId,
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível recuperar o perfil.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw ProfileFailure(message: error);
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw ProfileFailure(message: "O servidor não respondeu.");
    }
    return UserModel.fromJson(responseMap);
  }

  Future<UserModel> editUserProfile({
    required String sessionId,
    required String oldUserName,
    String? newEmail,
    String? newUsername,
  }) async {
    var url = Uri.https(ApiRoutes.baseUrl, "${ApiRoutes.users}/$oldUserName");

    var response = await _httpClient.put(
      url,
      headers: {
        "session_id": sessionId,
      },
      body: {
        "username": newUsername,
        "email": newEmail,
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errorBody = jsonDecode(response.body);
      String message = "Não foi possível editar o perfil.";
      errorBody.putIfAbsent('message', () => message);
      String error = jsonEncode(errorBody);
      throw ProfileFailure(message: error);
    }
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseMap.isEmpty) {
      throw ProfileFailure(message: "O servidor não respondeu.");
    }
    return UserModel.fromJson(responseMap);
  }
}
