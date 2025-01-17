import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_constants.dart';

class UnsplashApi {
  final http.Client _client;

  UnsplashApi({http.Client? client}) : _client = client ?? http.Client();

  Future<List<dynamic>> getPhotos({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.unsplashBaseUrl}/photos?page=$page&per_page=${AppConstants.pageSize}'),
      headers: {'Authorization': 'Client-ID ${ApiConstants.unsplashApiKey}'},
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<dynamic>> searchPhotos(String query, {int page = 1}) async {
    final response = await _client.get(
      Uri.parse(
        '${ApiConstants.unsplashBaseUrl}/search/photos?query=$query&page=$page&per_page=${AppConstants.pageSize}',
      ),
      headers: {'Authorization': 'Client-ID ${ApiConstants.unsplashApiKey}'},
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'] as List<dynamic>;
    } else {
      throw Exception('Failed to search photos');
    }
  }
} 