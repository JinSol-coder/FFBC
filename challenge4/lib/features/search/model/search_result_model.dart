class SearchResultItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String section;

  SearchResultItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.section,
  });
}

class SearchResults {
  final List<SearchResultItem> news;
  final List<SearchResultItem> recommendations;
  final List<SearchResultItem> market;

  SearchResults({
    required this.news,
    required this.recommendations,
    required this.market,
  });
} 