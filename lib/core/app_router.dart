import 'package:go_router/go_router.dart';
import 'package:tab_newz/home_news/view/home_page.dart';

class AppRouter {
  final start = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
