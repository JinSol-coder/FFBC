class SearchHistoryModel {
  final String query;
  final DateTime timestamp;

  SearchHistoryModel({
    required this.query,
    required this.timestamp,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      query: json['query'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'timestamp': timestamp.toIso8601String(),
    };
  }
} 