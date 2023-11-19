part of 'home_news_bloc.dart';

sealed class HomeNewsBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllNewsFetched extends HomeNewsBlocEvent {}
