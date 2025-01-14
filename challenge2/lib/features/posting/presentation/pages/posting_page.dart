import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posting_provider.dart';
import '../widgets/image_picker_widget.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostingProvider(),
      child: const PostingPageContent(),
    );
  }
}

class PostingPageContent extends StatelessWidget {
  const PostingPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시글'),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Consumer<PostingProvider>(
            builder: (context, provider, child) {
              return FilledButton(
                onPressed: provider.canPost && !provider.isLoading
                    ? () => _handlePost(context, provider)
                    : null,
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('게시'),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Consumer<PostingProvider>(
                builder: (context, provider, child) {
                  return TextField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      hintText: '무슨 일이 일어나고 있나요?',
                      border: InputBorder.none,
                    ),
                    onChanged: provider.updateContent,
                  );
                },
              ),
              const SizedBox(height: 16),
              const ImagePickerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePost(BuildContext context, PostingProvider provider) async {
    await provider.createPost();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
} 