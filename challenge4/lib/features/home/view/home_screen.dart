import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import '../../../shared/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(
      () => context.read<HomeViewModel>().fetchNews(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeViewModel>().fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: () => viewModel.fetchNews(refresh: true),
            child: viewModel.news.isEmpty && viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: viewModel.news.length + (viewModel.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == viewModel.news.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return NewsCard(news: viewModel.news[index]);
                    },
                  ),
          );
        },
      ),
    );
  }
} 