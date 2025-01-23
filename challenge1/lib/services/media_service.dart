import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class MediaService {
  static const maxImageWidth = 1280.0;
  static const maxImageHeight = 1280.0;
  static const thumbSize = 200;
  static const jpegQuality = 85;

  final _logger = Logger('MediaService');

  Future<Map<String, File?>> processCommentMedia(File file) async {
    try {
      // 파일 형식 검증
      final extension = path.extension(file.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.mp4'].contains(extension)) {
        throw Exception('지원하지 않는 파일 형식입니다.');
      }

      // 파일 크기 검증
      final fileSize = await file.length();
      final isImage = ['.jpg', '.jpeg', '.png'].contains(extension);
      if (isImage && fileSize > 5 * 1024 * 1024) {
        // 5MB
        throw Exception('이미지 크기는 5MB를 초과할 수 없습니다.');
      }
      if (!isImage && fileSize > 20 * 1024 * 1024) {
        // 20MB
        throw Exception('동영상 크기는 20MB를 초과할 수 없습니다.');
      }

      if (!isImage) {
        // 동영상인 경우 원본만 반환
        return {
          'original': file,
          'thumbnail': null,
        };
      }

      // 이미지 압축 및 리사이징
      final compressedFile = await compressAndResizeImage(file);
      final thumbnailFile = await createThumbnail(file);

      return {
        'original': compressedFile,
        'thumbnail': thumbnailFile,
      };
    } catch (e) {
      _logger.warning('미디어 처리 실패: $e');
      rethrow;
    }
  }

  Future<File?> compressAndResizeImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(dir.path, '${const Uuid().v4()}.jpg');

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: jpegQuality,
        minWidth: maxImageWidth.toInt(),
        minHeight: maxImageHeight.toInt(),
        format: CompressFormat.jpeg,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      _logger.warning('이미지 압축 실패: $e');
      return null;
    }
  }

  Future<File?> createThumbnail(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(dir.path, 'thumb_${const Uuid().v4()}.jpg');

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: jpegQuality,
        minWidth: thumbSize,
        minHeight: thumbSize,
        format: CompressFormat.jpeg,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      _logger.warning('썸네일 생성 실패: $e');
      return null;
    }
  }
}
