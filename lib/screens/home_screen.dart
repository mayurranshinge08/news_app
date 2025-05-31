import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../cubits/news_cubit.dart';
import '../cubits/news_state.dart';
import '../widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  final List<String> categories = [
    'general',
    'tech',
    'politics',
    'sports',
    'business',
    'entertainment',
  ];

  String selectedCategory = 'general';

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNewsByCategory(selectedCategory);
  }

  void _onRefresh() {
    context.read<NewsCubit>().getNewsByCategory(selectedCategory);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News App")),
      body: Column(
        children: [
          // Category buttons
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                      context.read<NewsCubit>().getNewsByCategory(category);
                    },
                    child: Text(
                      category[0].toUpperCase() + category.substring(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          // News list
          Expanded(
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) =>
                          NewsTile(article: state.articles[index]),
                    ),
                  );
                } else if (state is NewsError) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                  child: Text("Select a category to view news"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
