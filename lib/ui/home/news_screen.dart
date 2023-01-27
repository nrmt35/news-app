import 'package:flutter/material.dart';
import 'package:news_app/ui/home/all_news_widget.dart';
import 'package:news_app/ui/home/top_headlines_widget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top news'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt_rounded)),
              Tab(icon: Icon(Icons.list_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllNewsWidget(),
            TopHeadlinesWidget(),
          ],
        ),
      ),
    );
  }
}
