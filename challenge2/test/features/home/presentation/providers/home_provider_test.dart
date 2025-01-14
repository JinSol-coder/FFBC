import 'package:flutter_test/flutter_test.dart';
import 'package:challenge2/features/home/presentation/providers/home_provider.dart';

void main() {
  group('HomeProvider', () {
    late HomeProvider provider;

    setUp(() {
      provider = HomeProvider();
    });

    test('initial state is correct', () {
      expect(provider.posts, isEmpty);
      expect(provider.isLoading, isFalse);
      expect(provider.hasMore, isTrue);
    });

    test('loadInitialPosts updates state correctly', () async {
      expect(provider.posts, isEmpty);
      
      await provider.loadInitialPosts();
      
      expect(provider.posts, isNotEmpty);
      expect(provider.isLoading, isFalse);
      expect(provider.hasMore, isTrue);
    });

    test('loadMorePosts adds more posts', () async {
      await provider.loadInitialPosts();
      final initialCount = provider.posts.length;
      
      await provider.loadMorePosts();
      
      expect(provider.posts.length, greaterThan(initialCount));
      expect(provider.isLoading, isFalse);
    });
  });
} 