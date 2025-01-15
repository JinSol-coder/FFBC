import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/posting_provider.dart';
import '../../../home/presentation/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/app_state_provider.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostingProvider()),
        ChangeNotifierProvider.value(
          value: Provider.of<AppStateProvider>(context, listen: false),
        ),
      ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '사용자 닉네임',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<PostingProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          maxLines: 5,
                          maxLength: 500,
                          decoration: const InputDecoration(
                            hintText: '무슨 일이 일어나고 있나요?',
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          onChanged: provider.updateContent,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.photo_camera),
                        onPressed: () =>
                            _showImagePicker(context, ImageSource.camera),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.photo_library),
                        onPressed: () =>
                            _showImagePicker(context, ImageSource.gallery),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<PostingProvider>(
              builder: (context, provider, child) {
                if (provider.image != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(provider.image!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: provider.removeImage,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context, ImageSource source) {
    context.read<PostingProvider>().pickImage(source);
  }

  Future<void> _handlePost(
      BuildContext context, PostingProvider provider) async {
    await provider.createPost(context);
    if (context.mounted) {
      context.read<AppStateProvider>().setIndex(0);
      context.go('/');
    }
  }
}
