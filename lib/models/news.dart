import 'package:news_app/models/source.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News> news;

  NewsResponse({
    this.status,
    this.totalResults,
    this.news = const [],
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      news: List<News>.from(
        json['articles'].map((j) => News.fromJson(j)),
      ),
    );
  }
}

class News {
  Source? source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String? publishedAt;
  String content;

  News({
    this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: json['source'] == null ? null : Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "title": title,
        "author": author,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };
}
