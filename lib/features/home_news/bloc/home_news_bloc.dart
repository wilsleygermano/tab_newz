import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tab_news_api/tab_news_api.dart';

part 'home_news_bloc_event.dart';
part 'home_news_bloc_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

class HomeNewsBloc extends Bloc<HomeNewsBlocEvent, HomeNewsBlocState> {
  HomeNewsBloc() : super(const HomeNewsBlocState()) {
    on<AllNewsFetched>((event, emit) {
      return _fetchNews(event, emit);
    }, transformer: debounceTransformer(throttleDuration));
  }
  final _api = TabNewsAPiClient();
  int _page = 1;

  Future<void> _fetchNews(
    HomeNewsBlocEvent event,
    Emitter<HomeNewsBlocState> emit,
  ) async {
    if (state.hasReachedMax || state.status == HomeNewsStatus.loading) {
      return;
    }
    try {
      if (state.status == HomeNewsStatus.initial) {
        emit(state.copyWith(status: HomeNewsStatus.loading));
        final news = await _api.getNews();
        _page++;
        return emit(state.copyWith(
          status: HomeNewsStatus.success,
          news: news,
          hasReachedMax: false,
          page: _page,
          numberOfNews: news.length,
        ));
      }
      final news = await _api.getNews(page: _page);
      emit(state.copyWith(status: HomeNewsStatus.loading));

      if (news.isEmpty) {
        return emit(state.copyWith(
            hasReachedMax: true, status: HomeNewsStatus.success));
      }
      _page++;
      return emit(state.copyWith(
        status: HomeNewsStatus.success,
        news: List.of(state.news)..addAll(news),
        hasReachedMax: false,
        page: _page,
        numberOfNews: news.length,
      ));
    } on Exception catch (e) {
      debugPrint(
          "[HOME NEWS BLOC ERROR]: Unable to fetch news.\n ${e.toString()}");
      return emit(state.copyWith(
        status: HomeNewsStatus.failure,
        news: [],
        hasReachedMax: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
