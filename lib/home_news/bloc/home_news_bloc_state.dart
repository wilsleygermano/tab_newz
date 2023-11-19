part of 'home_news_bloc.dart';

enum HomeNewsStatus { initial, success, failure, loading }

final class HomeNewsBlocState extends Equatable {
  const HomeNewsBlocState({
    this.status = HomeNewsStatus.initial,
    this.news = const <NewsModel>[],
    this.hasReachedMax = false,
    this.errorMessage = '',
    this.page = 1,
    this.numberOfNews = 0,
  });

  final HomeNewsStatus status;
  final List<NewsModel> news;
  final bool hasReachedMax;
  final String errorMessage;
  final int page;
  final int numberOfNews;

  HomeNewsBlocState copyWith({
    HomeNewsStatus? status,
    List<NewsModel>? news,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
    int? numberOfNews,
  }) {
    return HomeNewsBlocState(
      status: status ?? this.status,
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      numberOfNews: numberOfNews ?? this.numberOfNews,
    );
  }

  @override
  List<Object> get props => [status, news, hasReachedMax, errorMessage, page, numberOfNews];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return '''HomeNewsBlocState {
      status: $status,
      news: ${news.length},
      hasReachedMax: $hasReachedMax,
      errorMessage: $errorMessage,
      page: $page,
      numberOfNews: $numberOfNews,
    }''';
  }
}
