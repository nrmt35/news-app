import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/http/http_client.dart';
import 'package:news_app/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/endpoints.dart';

class NewsCubit extends Cubit<List<News>> {
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoint = Endpoints();

  NewsCubit() : super(<News>[]);

  Future<NewsResponse> getAllNews(int page) async {
    final response = await httpClient.get(endpoint.everything(page));
    NewsResponse newsResponse = NewsResponse.fromJson(response);
    return newsResponse;
  }

  Future<List<News>> getHeadlines() async {
    final response = await httpClient.get(endpoint.headlines);
    List<News> news = List<News>.from(
      (response['articles'] ?? []).map((j) => News.fromJson(j)),
    );
    return news;
  }

  Future<void> updateList(News news) async {
    List<News> _news = state.toList();
    if (_news.any((n) => n.title == news.title)) {
      _news.removeWhere((n) => n.title == news.title);
    } else {
      _news.add(news);
    }
    callShared(_news);
    emit(_news);
  }

  Future<void> callShared(List<News> news) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> dynamicNews = news.map((e) => e.toJson()).toList();
    await prefs.setString('news', jsonEncode(dynamicNews));
  }
}
