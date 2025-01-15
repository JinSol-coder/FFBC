import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
import '../widgets/search_result_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatefulWidget {
  const SearchPageContent({super.key});

  @override
  State<SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<SearchPageContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<SearchProvider>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.searchResults.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.searchResults.isEmpty) {
            return const Center(
              child: Text('검색어를 입력하세요'),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                provider.searchResults.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.searchResults.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return SearchResultItem(user: provider.searchResults[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: const InputDecoration(
        hintText: '검색',
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        context.read<SearchProvider>().search(value);
      },
    );
  }
}
