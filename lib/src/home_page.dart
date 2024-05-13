import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssl_demo/src/home_provider.dart';
import 'package:ssl_demo/src/model/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider provider;
  @override
  void initState() {
    provider = context.read<HomeProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getNews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Consumer<HomeProvider>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.news.length,
            itemBuilder: (context, index) {
              News news = provider.news[index];
              return Column(
                children: [
                  Text(news.author ?? "author"),
                  Text(news.title ?? "title"),
                  Text(news.description ?? "description"),
                  Text(news.content ?? "content"),
                ],
              );
            },
          ),
        ));
  }
}
