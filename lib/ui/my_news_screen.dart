import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/ui/home/news_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/news.dart';
import 'home/news_detail_screen.dart';

class MyNewsScreen extends StatefulWidget {
  const MyNewsScreen({Key? key}) : super(key: key);

  @override
  State<MyNewsScreen> createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {

  Future<void> getFromPref() async {
    final newsBloc = BlocProvider.of<NewsCubit>(context);
    final prefs = await SharedPreferences.getInstance();
    String? strNews = prefs.getString('news');
    List<dynamic> dynamicNews = strNews != null ? jsonDecode(strNews) : [];
    for (var e in dynamicNews) {
      newsBloc.state.add(News.fromJson(e));
    }
  }

  @override
  void initState() {
    getFromPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My news'),
      ),
      body: Builder(builder: (context) {
        final newsBloc = BlocProvider.of<NewsCubit>(context, listen: true);
        return newsBloc.state.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: newsBloc.state.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                          news: newsBloc.state[index],
                        ),
                      ),
                    ),
                    child: NewsItem(
                      news: newsBloc.state[index],
                    ),
                  );
                },
              )
            : const Center(
                child: Text('News not found'),
              );
      }),
    );
  }
}
