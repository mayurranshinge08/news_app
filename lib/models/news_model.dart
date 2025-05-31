import 'package:hive/hive.dart';

part 'news_model.g.dart'; // required for generated adapter

@HiveType(typeId: 0)
class NewsArticle extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String publishedAt;

  @HiveField(5)
  final String source;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'] ?? '',
      url: json['url'],
      imageUrl: json['image_url'] ?? '',
      publishedAt: json['published_at'],
      source: json['source'] ?? '',
    );
  }
}
