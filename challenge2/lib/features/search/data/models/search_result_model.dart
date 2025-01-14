import '../../../home/data/models/user_model.dart';

class SearchResultModel {
  final List<UserModel> users;
  final bool hasMore;

  const SearchResultModel({
    required this.users,
    this.hasMore = true,
  });
} 