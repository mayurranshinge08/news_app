import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsService newsService;

  NewsCubit(this.newsService) : super(NewsInitial());

  void getNews() async {
    try {
      emit(NewsLoading());
      final articles = await newsService.fetchNews();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  void getNewsByCategory(String category) async {
    try {
      emit(NewsLoading());
      final articles = await newsService.fetchNews(category: category);
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
