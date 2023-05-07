import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/chat_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageController extends GetxController {
  static ImageController instance = Get.find();

  File? _imageFile;

  var _downloadURL;
  get imageDownloadURL => _downloadURL;

  Future getGalleryImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        _imageFile = File(value.path);
        update();
      }
    });
  }

  Future getCameraImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        _imageFile = File(value.path);
        update();
      }
    });
  }

  Future uploadImage() async {
    String filename = Uuid().v1();
    var ref = FirebaseStorage.instance
        .ref()
        .child('message_images')
        .child("${filename}.jpg");

    var uploader = await ref.putFile(_imageFile!);

    String downloadUrl = await uploader.ref.getDownloadURL();
    _downloadURL = downloadUrl;
    update();
  }
}
