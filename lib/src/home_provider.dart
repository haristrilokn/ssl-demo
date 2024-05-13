import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';
import 'model/news.dart';

class HomeProvider extends ChangeNotifier {
  List<News> news = [];

  Future<SecurityContext> get globalContext async {
    print("Loading SSL certificate...");
    final sslCert = await rootBundle.load('assets/stackoverflow.crt');
    // final sslCert = await rootBundle.load('assets/newsapi.org.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    print("SSL certificate loaded.");
    return securityContext;
  }

  Future<HttpClient> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = ((cert, host, port) => false);
    print("HTTP client created with SSL pinning enabled.");
    return client;
  }

  Future<void> getNews() async {
    try {
      final HttpClient sslPinningClient = await getSSLPinningClient();
      final dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = sslPinningClient;
        return client;
      };
      await dio
          .get("https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey")
          .then((response) {
        log(response.data.toString());
        List<dynamic> data = response.data['articles'];
        news = data.map((e) {
          return News.fromMap(e);
        }).toList();
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}
