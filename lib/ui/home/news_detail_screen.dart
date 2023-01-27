import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/news_bloc.dart';
import '../../models/news.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;

  const NewsDetailScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.source!.name!),
        actions: [
          Builder(builder: (context) {
            final newsBloc = BlocProvider.of<NewsCubit>(context, listen: true);
            return IconButton(
              onPressed: () {
                newsBloc.updateList(widget.news);
              },
              icon: Icon(
                newsBloc.state.contains(widget.news) ? Icons.bookmark_added : Icons.bookmark,
              ),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              fit: BoxFit.contain,
              imageUrl: widget.news.urlToImage,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.news.title,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Автор: ${widget.news.author}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.news.description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.news.content,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
