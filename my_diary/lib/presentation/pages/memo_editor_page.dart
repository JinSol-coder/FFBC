import 'dart:io';  // File 클래스를 위해 추가
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/memo_editor_controller.dart';

class MemoEditorPage extends GetView<MemoEditorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 작성'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: controller.saveMemo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '제목을 입력하세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.title.value = value,
            ),
            SizedBox(height: 16),
            _buildFormatToolbar(),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              minLines: 10,
              onChanged: (value) => controller.content.value = value,
            ),
            SizedBox(height: 16),
            _buildMediaButtons(),
            SizedBox(height: 16),
            _buildMediaPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatToolbar() {
    return Container(
      padding: EdgeInsets.all(8),
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
      icon: Icon(Icons.color_lens),
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
          icon: Icon(Icons.image),
          label: Text('이미지 추가'),
          onPressed: controller.pickImage,
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.video_library),
          label: Text('동영상 추가'),
          onPressed: controller.pickVideo,
        ),
      ],
    );
  }

  Widget _buildMediaPreview() {
    return Obx(() => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: controller.mediaFiles.asMap().entries.map((entry) {
        final index = entry.key;
        final path = entry.value;
        return Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                  image: NetworkImage(path),  // FileImage 대신 NetworkImage 사용
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: -12,
              top: -12,
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 20, color: Colors.red),
                ),
                onPressed: () => controller.removeMedia(index),
              ),
            ),
          ],
        );
      }).toList(),
    ));
  }
} 