import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_viewmodel.dart';
import '../../../shared/widgets/search_bar.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(),
          ),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.results == null) {
                  return const Center(child: Text('검색어를 입력하세요'));
                }

                return const SearchResultsScreen();
              },
            ),
          ),
        ],
      ),
    );
  }
} 