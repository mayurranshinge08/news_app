import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String baseUrl =
      "https://api.thenewsapi.com/v1/news/top?api_token=FEqPcvx3Vw8fkAd3ylnFCzu7rl8smybAzCcaamjm&locale=us&limit=10";

  Future<List<NewsArticle>> fetchNews({String category = ''}) async {
    String apiUrl = baseUrl;
    if (category.isNotEmpty) {
      apiUrl += "&categories=$category";
    }

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      return data.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }
}
