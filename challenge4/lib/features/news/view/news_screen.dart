import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/news_viewmodel.dart';
import '../model/news_category_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String _selectedCategory = '전체';

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsViewModel>().fetchNews(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뉴스'),
      ),
      body: Consumer<NewsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = ['전체', ...viewModel.categories.map((c) => c.title)];

          return Column(
            children: [
              // 카테고리 필터
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: _selectedCategory == category,
                        label: Text(category),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              // 뉴스 목록
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.categories[index];
                    if (_selectedCategory != '전체' && 
                        category.title != _selectedCategory) {
                      return const SizedBox.shrink();
                    }
                    return _buildNewsCategory(category);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNewsCategory(NewsCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedCategory == '전체')
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.items.length,
          itemBuilder: (context, index) {
            final item = category.items[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  // TODO: 뉴스 상세 페이지로 이동
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
} 