import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/recommend_viewmodel.dart';
import '../model/recommend_model.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<RecommendViewModel>().fetchRecommendations(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천'),
      ),
      body: Consumer<RecommendViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) {
              final category = viewModel.categories[index];
              return _buildRecommendCategory(category);
            },
          );
        },
      ),
    );
  }

  Widget _buildRecommendCategory(RecommendCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  // TODO: 상세 정보 표시
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          _buildTrendIndicator(item),
                        ],
                      ),
                      if (item.exchangeRate != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.exchangeRate!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getRecommendationColor(item.recommendation),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item.recommendation,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrendIndicator(RecommendItem item) {
    final color = item.trend == '상승' ? Colors.red : Colors.blue;
    final icon = item.trend == '상승' ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          item.percentage,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Color _getRecommendationColor(String recommendation) {
    switch (recommendation) {
      case '매수 고려':
        return Colors.green;
      case '환전 고려':
        return Colors.blue;
      case '환전 대기':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
} 