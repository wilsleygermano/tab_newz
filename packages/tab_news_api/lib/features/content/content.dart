import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:tab_news_api/constants/api_routes.dart';

import 'package:tab_news_api/data/model/models.dart';

class NewsRequestFailure implements Exception {
  final String message;

  NewsRequestFailure(
      {this.message = 'Não foi possível requisitar as notícias.'});
}

class NewsNotFoundFailure implements Exception {
  final String message;

  NewsNotFoundFailure({this.message = 'Nenhuma notícia encontrada.'});
}

class SelectedNewsRequestFailure implements Exception {
  final String message;

  SelectedNewsRequestFailure(
      {this.message = 'Não foi possível requisitar a notícia.'});
}

class SelectedNewsNotFoundFailure implements Exception {
  final String message;

  SelectedNewsNotFoundFailure({this.message = 'Notícia não encontrada.'});
}

class SelectedNewsCommentsRequestFailure implements Exception {
  final String message;

  SelectedNewsCommentsRequestFailure(
      {this.message = 'Não foi possível requisitar os comentários.'});
}

class SelectedNewsCommentsNotFoundFailure implements Exception {
  final String message;

  SelectedNewsCommentsNotFoundFailure(
      {this.message = 'Nenhum comentário encontrado.'});
}

class Content {
  Content({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const String _page = "page";

  final http.Client _httpClient;

  Future<List<NewsModel>> getNews({int? page = 1}) async {
    var url =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.contents, {_page: '$page'});
    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw NewsRequestFailure();
    }

    List responseList = jsonDecode(response.body);

    if (responseList.isEmpty) {
      throw NewsNotFoundFailure();
    }
    List<NewsModel> newsList = [];
    for (var i = 0; i < responseList.length; i++) {
      newsList.add(NewsModel.fromJson(responseList[i]));
    }
    return newsList;
  }

  Future<NewsModel> getSelectedNews({
    required String ownerName,
    required String newsSlug,
  }) {
    var url = Uri.https(
        ApiRoutes.baseUrl, "${ApiRoutes.contents}/$ownerName/$newsSlug");
    return _httpClient.get(url).then((response) {
      if (response.statusCode != 200) {
        throw SelectedNewsRequestFailure();
      }
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      if (responseMap.isEmpty) {
        throw SelectedNewsNotFoundFailure();
      }
      return NewsModel.fromJson(responseMap);
    });
  }

  Future<List<NewsModel>> getComments({
    required String ownerName,
    required String newsSlug,
  }) {
    var url = Uri.https(ApiRoutes.baseUrl,
        "${ApiRoutes.contents}/$ownerName/$newsSlug/${ApiRoutes.children}");
    return _httpClient.get(url).then((response) {
      if (response.statusCode != 200) {
        throw SelectedNewsCommentsRequestFailure();
      }
      List responseList = jsonDecode(response.body);

      if (responseList.isEmpty) {
        throw SelectedNewsCommentsNotFoundFailure();
      }
      List<NewsModel> newsList = [];
      for (var i = 0; i < responseList.length; i++) {
        newsList.add(NewsModel.fromJson(responseList[i]));
      }
      return newsList;
    });
  }
}
