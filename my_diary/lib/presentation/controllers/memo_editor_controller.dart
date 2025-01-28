import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/memo.dart';
import '../../domain/repositories/memo_repository.dart';
import '../controllers/memo_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class MemoEditorController extends GetxController {
  final MemoRepository _repository;
  final title = ''.obs;
  final content = ''.obs;
  final selectedStyle = RxMap<String, bool>({
    'bold': false,
    'italic': false,
    'underline': false,
    'strikethrough': false,
  });
  final selectedColor = Colors.black.obs;
  final mediaFiles = RxList<String>([]);

  MemoEditorController(this._repository);

  void toggleStyle(String style) {
    selectedStyle[style] = !(selectedStyle[style] ?? false);
  }

  void setColor(Color color) {
    selectedColor.value = color;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        // Firebase Storage에 이미지 업로드
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef = storageRef.child('memos/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
        await imageRef.putFile(File(image.path));
        final imageUrl = await imageRef.getDownloadURL();
        
        // 로컬 상태에 이미지 URL 추가
        mediaFiles.add(imageUrl);
      } catch (e) {
        Get.snackbar('오류', '이미지 업로드에 실패했습니다.');
      }
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      // TODO: 비디오 업로드 및 URL 저장 구현
      mediaFiles.add(video.path);
    }
  }

  void removeMedia(int index) {
    mediaFiles.removeAt(index);
  }

  Future<void> saveMemo() async {
    if (title.value.isEmpty) {
      Get.snackbar('오류', '제목을 입력해주세요.');
      return;
    }

    try {
      final memo = Memo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.value,
        content: content.value,
        createdAt: DateTime.now(),
        imageUrls: mediaFiles.toList(),  // 이미지 URL 리스트 추가
      );
      
      await _repository.createMemo(memo);
      
      // 홈 화면의 MemoController 찾아서 메모 목록 새로고침
      final memoController = Get.find<MemoController>();
      await memoController.loadMemos();
      
      // 홈 화면으로 이동
      Get.offAllNamed('/home');
      Get.snackbar('성공', '메모가 저장되었습니다.');
      
    } catch (e) {
      // print 대신 로깅 프레임워크 사용
      Get.snackbar('오류', '메모 저장에 실패했습니다: $e');
    }
  }

  Future<Memo> loadMemoForEdit(String id) async {
    try {
      final memo = await _repository.getMemoById(id);
      title.value = memo.title;
      content.value = memo.content;
      return memo;
    } catch (e) {
      Get.snackbar('오류', '메모를 불러오는데 실패했습니다.');
      throw e;
    }
  }

  Future<void> updateMemo(String id) async {
    if (title.value.isEmpty) {
      Get.snackbar('오류', '제목을 입력해주세요.');
      return;
    }

    try {
      final memo = Memo(
        id: id,
        title: title.value,
        content: content.value,
        createdAt: DateTime.now(),  // 원래 생성일은 유지해야 하지만 예시에서는 단순화
        updatedAt: DateTime.now(),
      );
      
      await _repository.updateMemo(memo);
      
      // 홈 화면의 MemoController 찾아서 메모 목록 새로고침
      final memoController = Get.find<MemoController>();
      await memoController.loadMemos();
      
      // 상세 화면으로 돌아가기
      Get.back();
      Get.snackbar('성공', '메모가 수정되었습니다.');
      
    } catch (e) {
      Get.snackbar('오류', '메모 수정에 실패했습니다: $e');
    }
  }
} 