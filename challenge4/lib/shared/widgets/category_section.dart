import 'package:flutter/material.dart';
import '../../features/home/model/content_model.dart';
import '../../features/home/view/more_content_screen.dart';
import '../widgets/crypto_price_painter.dart';

class CategorySection extends StatelessWidget {
  final ContentCategory category;

  const CategorySection({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // 카테고리별 다른 레이아웃 적용
    switch (category.title) {
      case 'AI 뉴스':
        return _buildAINewsSection(context);
      case '주식':
        return _buildStockSection(context);
      case '비트코인':
        return _buildCryptoSection(context);
      case '환율 통계':
        return _buildExchangeRateSection(context);
      default:
        return _buildDefaultSection(context);
    }
  }

  Widget _buildAINewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.items.length,
            itemBuilder: (context, index) {
              final item = category.items[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.all(8),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
        ),
      ],
    );
  }

  Widget _buildStockSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.items.length,
            itemBuilder: (context, index) {
              final item = category.items[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.all(8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, showMore: false),
        Container(
          height: 200,
          width: double.infinity,
          child: CustomPaint(
            painter: CryptoPricePainter(),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.items.length,
          itemBuilder: (context, index) {
            final item = category.items[index];
            return ListTile(
              title: Text(item.title),
              trailing: Text(
                item.description,
                style: TextStyle(
                  color: item.description.contains('+') ? Colors.red : Colors.blue,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildExchangeRateSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
          itemCount: category.items.length,
          itemBuilder: (context, index) {
            final item = category.items[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium,
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

  Widget _buildSectionHeader(BuildContext context, {bool showMore = true}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (showMore && category.title != '비트코인')
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoreContentScreen(
                      categoryTitle: category.title,
                      items: category.items,
                    ),
                  ),
                );
              },
              child: const Text('더보기'),
            ),
        ],
      ),
    );
  }

  Widget _buildDefaultSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.items.length,
          itemBuilder: (context, index) {
            final item = category.items[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.description),
            );
          },
        ),
      ],
    );
  }
} 