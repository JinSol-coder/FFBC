import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import '../../../shared/widgets/news_card.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/category_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<HomeViewModel>().fetchContents(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            title: CustomSearchBar(),
          ),
          Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = viewModel.categories[index];
                    return CategorySection(category: category);
                  },
                  childCount: viewModel.categories.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 