import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: const BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 120,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.contain,
            imageUrl: news.urlToImage,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  news.author,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    news.description,

                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
