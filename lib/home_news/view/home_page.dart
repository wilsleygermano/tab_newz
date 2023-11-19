import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tab_newz/constants/app_assets.dart';
import 'package:tab_newz/constants/app_strings.dart';
import 'package:tab_newz/core/tools/time_formatter.dart';
import 'package:tab_newz/home_news/bloc/home_news_bloc.dart';
import 'package:tab_newz/home_news/widget/icon_badge.dart';
import 'package:tab_newz/home_news/widget/news_list.dart';
import 'package:tab_newz/home_news/widget/news_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeNewsBloc()
          ..add(
            AllNewsFetched(),
          ),
        child: const NewsList(),
      ),
    );
  }
}
