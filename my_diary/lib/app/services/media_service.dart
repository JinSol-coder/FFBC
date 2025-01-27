import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class MediaService extends GetxService {
  final _imagePicker = ImagePicker();
  final RxList<VideoPlayerController> videoControllers = <VideoPlayerController>[].obs;

  Future<List<XFile>> pickImages() async {
    try {
      final images = await _imagePicker.pickMultiImage();
      return images;
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images');
      return [];
    }
  }

  Future<XFile?> pickVideo() async {
    try {
      final video = await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        final controller = VideoPlayerController.file(video.path as dynamic);
        await controller.initialize();
        videoControllers.add(controller);
      }
      return video;
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick video');
      return null;
    }
  }

  void disposeControllers() {
    for (final controller in videoControllers) {
      controller.dispose();
    }
    videoControllers.clear();
  }
} 