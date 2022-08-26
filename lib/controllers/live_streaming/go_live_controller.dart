import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sports_gurukul/controllers/auth/auth_controller.dart';
import 'package:sports_gurukul/models/live_streaming_model.dart';


class GoLiveController extends GetxController {
  final AuthController _authController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<String> startLiveStream(String title) async {
    String channelId = '';
    try {
      if (title.isNotEmpty && selectedImagePath.value != null) {
        channelId =
            '${_authController.firebaseUser.value!.uid}${_authController.firebaseUser.value!.displayName}';
        String uid = _authController.firebaseUser.value!.uid;
        String username = '${_authController.firebaseUser.value!.displayName}';
        if (!((await _firestore
                .collection('liveStreaming')
                .doc(channelId)
                .get())
            .exists)) {
          String thumbnailUrl =
              await uploadImageToStorage('livestream-thumbnails', uid);

          LiveStreaming liveStreaming = LiveStreaming(
              title, thumbnailUrl, uid, username, channelId, DateTime.now(), 0);
          _firestore
              .collection('liveStreaming')
              .doc(channelId)
              .set(liveStreaming.toMap());
        } else {
          Get.snackbar('Error', 'Two LiveStreams cannot run at the same time');
        }
      } else {
        Get.snackbar('Error', 'Please fill all the fields.');
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message!);
    }
    print('$channelId ################################################');
    return channelId;
  }

  Future<String> uploadImageToStorage(String childName, String uid) async {
    Reference ref = _storage.ref().child(childName).child(uid);
    File file = File(selectedImagePath.value);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> endLiveStream(String channelId) async {
    print('channelId@@@@@@@@@@@@');
    print(channelId);
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('liveStreaming')
          .doc(channelId)
          .collection("comments")
          .get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        await _firestore
            .collection('liveStreaming')
            .doc(channelId)
            .collection('comments')
            .doc(
              ((querySnapshot.docs[i].data()! as dynamic)['commentId']),
            )
            .delete();
      }
      await _firestore.collection('liveStreaming').doc(channelId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateViewCount(String id, bool isIncrease) async {
    try {
      await _firestore.collection('liveStreaming').doc(id).update({
        'viewers': FieldValue.increment(isIncrease ? 1 : -1),
      });
    } catch (e) {
      print(e.toString());
    }
  }


}
