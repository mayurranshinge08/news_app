import 'package:hive/hive.dart';
import '../models/news_model.dart';

class BookmarkService {
  final _box = Hive.box<NewsArticle>('bookmarks');

  List<NewsArticle> getBookmarks() => _box.values.toList();

  void addBookmark(NewsArticle article) {
    if (!_box.values.any((item) => item.url == article.url)) {
      _box.add(article);
    }
  }

  void removeBookmark(String url) {
    final key = _box.keys.firstWhere(
          (k) => _box.get(k)?.url == url,
      orElse: () => null,
    );
    if (key != null) {
      _box.delete(key);
    }
  }

  bool isBookmarked(String url) {
    return _box.values.any((item) => item.url == url);
  }
}
