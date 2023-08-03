
import 'package:image_picker/image_picker.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = StateNotifierProvider.autoDispose<ImageProvider1, XFile?>((ref) => ImageProvider1(null));
final imageProvider2 = StateNotifierProvider.autoDispose<ImageProvider1, XFile?>((ref) => ImageProvider1(null));


class ImageProvider1 extends StateNotifier<XFile?>{
  ImageProvider1(super.state);

  void pickAnImage() async{
    final ImagePicker _picker = ImagePicker();
    state = await _picker.pickImage(source: ImageSource.gallery);
  }

  void camera() async{
    final ImagePicker _picker = ImagePicker();
    state = await _picker.pickImage(source: ImageSource.camera);
  }

}
