import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/ui/home/news_item.dart';

import 'news_detail_screen.dart';

class TopHeadlinesWidget extends StatefulWidget {
  const TopHeadlinesWidget({Key? key}) : super(key: key);

  @override
  State<TopHeadlinesWidget> createState() => _TopHeadlinesWidgetState();
}

class _TopHeadlinesWidgetState extends State<TopHeadlinesWidget>
    with AutomaticKeepAliveClientMixin {
  late Future<List<News>> newsFuture;

  @override
  void initState() {
    newsFuture = BlocProvider.of<NewsCubit>(context).getHeadlines();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> refreshState() async {
    setState(() {
      newsFuture = BlocProvider.of<NewsCubit>(context).getHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<News>>(
      future: newsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => refreshState(),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(
                              news: snapshot.data![index],
                            ),
                          ),
                        ),
                    child: NewsItem(news: snapshot.data![index]));
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        }
      },
    );
  }
}
