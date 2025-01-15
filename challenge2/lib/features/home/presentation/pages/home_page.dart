import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/post_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadInitialPosts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeProvider>().loadMorePosts();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<HomeProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쓰레드'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.posts.isEmpty) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const PostSkeleton(),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: provider.posts.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.posts.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (provider.isRefreshing && index < 5) {
                  return const PostSkeleton();
                }

                return PostCard(post: provider.posts[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
