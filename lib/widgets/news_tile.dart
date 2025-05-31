import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../screens/webview_screen.dart';
import '../services/bookmark_service.dart';

class NewsTile extends StatefulWidget {
  final NewsArticle article;

  const NewsTile({super.key, required this.article});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  final BookmarkService _bookmarkService = BookmarkService();

  @override
  Widget build(BuildContext context) {
    final isBookmarked = _bookmarkService.isBookmarked(widget.article.url);

    return ListTile(
      leading:
          widget.article.imageUrl.isNotEmpty
              ? Image.network(
                widget.article.imageUrl,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://via.placeholder.com/100', // default fallback image URL
                    width: 100,
                    fit: BoxFit.cover,
                  );
                },
              )
              : const SizedBox(width: 100),
      title: Text(
        widget.article.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(widget.article.source),
      trailing: IconButton(
        icon: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: isBookmarked ? Colors.blue : null,
        ),
        onPressed: () {
          setState(() {
            if (isBookmarked) {
              _bookmarkService.removeBookmark(widget.article.url);
            } else {
              _bookmarkService.addBookmark(widget.article);
            }
          });
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebviewScreen(url: widget.article.url),
          ),
        );
      },
    );
  }
}
