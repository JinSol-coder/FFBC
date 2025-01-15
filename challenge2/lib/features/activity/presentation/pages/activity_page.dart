import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import '../widgets/activity_item.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityProvider()..loadActivities(),
      child: const ActivityPageContent(),
    );
  }
}

class ActivityPageContent extends StatefulWidget {
  const ActivityPageContent({super.key});

  @override
  State<ActivityPageContent> createState() => _ActivityPageContentState();
}

class _ActivityPageContentState extends State<ActivityPageContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ActivityProvider>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('활동'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.activities.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: provider.activities.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.activities.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return ActivityItem(activity: provider.activities[index]);
            },
          );
        },
      ),
    );
  }
}
