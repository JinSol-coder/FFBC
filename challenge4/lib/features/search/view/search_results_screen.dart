import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_viewmodel.dart';
import '../model/search_result_model.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.results == null) {
            return const Center(child: Text('검색어를 입력하세요'));
          }

          final results = viewModel.results!;
          final sections = [
            if (results.news.isNotEmpty)
              _buildSection('뉴스', results.news, viewModel.query),
            if (results.recommendations.isNotEmpty)
              _buildSection('추천', results.recommendations, viewModel.query),
            if (results.market.isNotEmpty)
              _buildSection('시장', results.market, viewModel.query),
          ];

          if (sections.isEmpty) {
            return const Center(child: Text('검색 결과가 없습니다'));
          }

          return ListView.separated(
            itemCount: sections.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => sections[index],
          );
        },
      ),
    );
  }

  Widget _buildSection(
    String title, 
    List<SearchResultItem> items, 
    String query,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildSearchResultItem(item, query);
          },
        ),
      ],
    );
  }

  Widget _buildSearchResultItem(SearchResultItem item, String query) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.network(
          item.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: _highlightText(item.title, query),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _highlightText(item.description, query),
            const SizedBox(height: 4),
            Text(
              item.category,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 12,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _highlightText(String text, String query) {
    if (query.isEmpty) return Text(text);

    final matches = RegExp(query, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) return Text(text);

    final spans = <TextSpan>[];
    var lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start != lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: const TextStyle(
          backgroundColor: Colors.yellow,
          color: Colors.black,
        ),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd != text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return RichText(text: TextSpan(children: spans));
  }
} 