import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/search/viewmodel/search_viewmodel.dart';
import '../../features/search/view/search_results_screen.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '검색어를 입력하세요',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox();
    
    final viewModel = context.read<SearchViewModel>();
    viewModel.search(query);
    return const SearchResultsScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
} 