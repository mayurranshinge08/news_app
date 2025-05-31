import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'cubits/news_cubit.dart';
import 'models/news_model.dart';
import 'services/news_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsArticleAdapter());
  await Hive.openBox<NewsArticle>('bookmarks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: BlocProvider(
        create: (_) => NewsCubit(NewsService())..getNews(),
        child: HomeScreen(),
      ),
    );
  }
}
