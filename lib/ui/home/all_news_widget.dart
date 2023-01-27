import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/ui/home/news_item.dart';

import 'news_detail_screen.dart';

class AllNewsWidget extends StatefulWidget {
  const AllNewsWidget({Key? key}) : super(key: key);

  @override
  State<AllNewsWidget> createState() => _AllNewsWidgetState();
}

class _AllNewsWidgetState extends State<AllNewsWidget> with AutomaticKeepAliveClientMixin {
  final _pagingController =
      PagingController<int, News>(firstPageKey: 1, invisibleItemsThreshold: 1);
  int items = 0;

  void _fetchPage(int page) {
    BlocProvider.of<NewsCubit>(context).getAllNews(page).then((response) {
      final newItems = response.news;
      if (response.totalResults! < items + 15) {
        items += 15;
        _pagingController.appendLastPage(newItems);
      } else {
        items += 15;
        _pagingController.appendPage(newItems, page + 1);
      }
    }).catchError((dynamic e) {
      _pagingController.error = e;
    });
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      _pagingController.refresh();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _pagingController.dispose();
    super.dispose();
  }

  Timer? timer;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PagedListView<int, News>(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        firstPageProgressIndicatorBuilder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        newPageErrorIndicatorBuilder: (_) => const Center(
          child: Text('Something went wrong'),
        ),
        firstPageErrorIndicatorBuilder: (_) => const Center(
          child: Text('Something went wrong'),
        ),
        newPageProgressIndicatorBuilder: (_) => const Align(
          alignment: Alignment.bottomCenter,
          child: CircularProgressIndicator(),
        ),
        noItemsFoundIndicatorBuilder: (_) => const Center(
          child: Text('News not found'),
        ),
        itemBuilder: (_, item, __) => GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                      news: item,
                    ),
                  ),
                ),
            child: NewsItem(news: item)),
      ),
    );
  }
}
