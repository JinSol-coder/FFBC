import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_viewmodel.dart';
import '../../../shared/widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final viewModel = context.read<SearchViewModel>();
      if (_searchController.text.isNotEmpty) {
        viewModel.search(_searchController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              context.read<SearchViewModel>().search(query, refresh: true);
            }
          },
        ),
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.searchResults.isEmpty && !viewModel.isLoading) {
            return ListView.builder(
              itemCount: viewModel.searchHistory.length,
              itemBuilder: (context, index) {
                final history = viewModel.searchHistory[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(history.query),
                  onTap: () {
                    _searchController.text = history.query;
                    viewModel.search(history.query, refresh: true);
                  },
                );
              },
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: viewModel.searchResults.length + (viewModel.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.searchResults.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return NewsCard(news: viewModel.searchResults[index]);
            },
          );
        },
      ),
    );
  }
} 