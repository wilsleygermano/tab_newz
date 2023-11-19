import 'package:flutter_test/flutter_test.dart';
import 'package:tab_newz/features/home_news/bloc/home_news_bloc.dart';

void main() {
  group("[Home News Bloc Group Test] - ", () {
    late HomeNewsBloc homeNewsBloc;

    setUp(() {
      homeNewsBloc = HomeNewsBloc();
    });

    test("First state should be initial", () {
      expect(homeNewsBloc.state,
          const HomeNewsBlocState(status: HomeNewsStatus.initial));
    });
  });

  //TODO: Add more test
}
