import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tab_newz/constants/app_assets.dart';
import 'package:tab_newz/constants/app_strings.dart';
import 'package:tab_newz/core/tools/time_formatter.dart';
import 'package:tab_newz/home_news/bloc/home_news_bloc.dart';
import 'package:tab_newz/home_news/widget/icon_badge.dart';
import 'package:tab_newz/home_news/widget/news_title.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late final ScrollController _scrollController;
  bool _centerTitle = false;
  late String _pageTitle;

  void _monitorScroll() {
    if (_scrollController.offset >= 75.0) {
      setState(() {
        _centerTitle = true;
        _pageTitle = AppStrings.home;
      });
    } else {
      setState(() {
        _centerTitle = false;
        _pageTitle = AppStrings.welcome;
      });
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= (maxScroll * 0.75)) {
      context.read<HomeNewsBloc>().add(AllNewsFetched());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _monitorScroll();
      _onScroll();
    });
    _pageTitle = AppStrings.welcome;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(() {
        _monitorScroll();
        _onScroll();
      })
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNewsBloc, HomeNewsBlocState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeNewsStatus.failure:
            return Center(child: Text(state.errorMessage));
          case HomeNewsStatus.success:
            if (state.news.isEmpty) {
              return const Center(child: Text('no news'));
            }
            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar.large(
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: _centerTitle,
                    expandedTitleScale: 1.5,
                    titlePadding: const EdgeInsets.only(
                      left: 8,
                      bottom: 16,
                    ),
                    title: Text(
                      _pageTitle,
                      style: Theme.of(context).textTheme.displayMedium,
                      maxLines: 1,
                    ),
                    background: Container(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final news = state.news[index];
                      return index >= state.news.length
                          ? const CircularProgressIndicator.adaptive()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${news.ownerUsername}, ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "${TimeFormatter().relativeTime(news.createdAt)}:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  //TODO: add share modal
                                                },
                                                child: SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child: SvgPicture.asset(
                                                      AppAssets.ellipsis,
                                                      fit: BoxFit.contain,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onBackground,
                                                        BlendMode.srcIn,
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          NewsTitle(
                                            title: news.title,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconBadge.comments(
                                                label: news.childrenDeepCount
                                                    .toString(),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              IconBadge.coin(
                                                label: news.tabcoins.toString(),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 0.3,
                                  )
                                ],
                              ),
                            );
                    },
                    childCount: state.hasReachedMax
                        ? state.news.length
                        : state.news.length + 1,
                  ),
                ),
              ],
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
