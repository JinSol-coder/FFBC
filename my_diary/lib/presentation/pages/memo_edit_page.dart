import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/memo_editor_controller.dart';
import '../../domain/models/memo.dart';

class MemoEditPage extends GetView<MemoEditorController> {
  final String memoId;

  MemoEditPage({super.key}) : memoId = Get.parameters['id']! {
    print('MemoEditPage constructed. MemoId: $memoId');
  }

  @override
  Widget build(BuildContext context) {
    print('MemoEditPage building. MemoId: $memoId');
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 수정'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => controller.updateMemo(memoId),
          ),
        ],
      ),
      body: FutureBuilder<Memo>(
        future: controller.loadMemoForEdit(memoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('에러가 발생했습니다.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: controller.title.value),
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => controller.title.value = value,
                ),
                const SizedBox(height: 16),
                _buildFormatToolbar(),
                const SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(text: controller.content.value),
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  minLines: 10,
                  onChanged: (value) => controller.content.value = value,
                ),
                const SizedBox(height: 16),
                _buildMediaButtons(),
                const SizedBox(height: 16),
                _buildMediaPreview(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormatToolbar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildStyleButton(Icons.format_bold, 'bold', '굵게'),
          _buildStyleButton(Icons.format_italic, 'italic', '기울임'),
          _buildStyleButton(Icons.format_underline, 'underline', '밑줄'),
          _buildStyleButton(Icons.format_strikethrough, 'strikethrough', '취소선'),
          _buildColorPicker(),
        ],
      ),
    );
  }

  Widget _buildStyleButton(IconData icon, String style, String tooltip) {
    return Obx(() => IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: controller.selectedStyle[style] == true ? Colors.blue : Colors.grey,
      onPressed: () => controller.toggleStyle(style),
    ));
  }

  Widget _buildColorPicker() {
    return PopupMenuButton<Color>(
      icon: const Icon(Icons.color_lens),
      tooltip: '색상',
      itemBuilder: (context) => [
        Colors.black,
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
      ].map((color) => PopupMenuItem(
        value: color,
        child: Container(
          width: 24,
          height: 24,
          color: color,
        ),
      )).toList(),
      onSelected: controller.setColor,
    );
  }

  Widget _buildMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.image),
          label: const Text('이미지 추가'),
          onPressed: controller.pickImage,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.video_library),
          label: const Text('동영상 추가'),
          onPressed: controller.pickVideo,
        ),
      ],
    );
  }

  Widget _buildMediaPreview() {
    return Obx(() => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: controller.mediaFiles.map((path) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          image: DecorationImage(
            image: FileImage(File(path)),
            fit: BoxFit.cover,
          ),
        ),
      )).toList(),
    ));
  }
} 