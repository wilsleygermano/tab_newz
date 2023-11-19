import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_newz/features/home_news/bloc/home_news_bloc.dart';
import 'package:tab_newz/features/home_news/widget/news_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmarks,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _setIndex,
      ),
    );
  }
}
