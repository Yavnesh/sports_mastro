import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../../config/agora.dart';
import '../../widgets/bottom_navigation/bottom_navigation.dart';
import '../auth/auth_controller.dart';
import '../live_streaming/go_live_controller.dart';
import 'package:http/http.dart' as http;

class BroadcastController extends GetxController {
  AuthController authController = Get.find();
  GoLiveController goLiveController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final RtcEngine engine;
  late String channelId = ''.obs as String;
  late bool isBroadcaster = false.obs as bool;
  late bool _switchCamera = true.obs as bool;
  late bool isMuted = false.obs as bool;
  late bool isLoading = false.obs as bool;
  List<int> remoteUid = [];

  initEngine() async {
    engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    addListeners();

    await engine.enableVideo();
    await engine.startPreview();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);

    if (isBroadcaster) {
      print('$isBroadcaster #################################  role broadcaster');
      engine.setClientRole(ClientRole.Broadcaster);
    } else {
      print('$isBroadcaster #################################  role audience');
      engine.setClientRole(ClientRole.Audience);
    }
    await joinChannel();
  }

  joinChannel() async {
    await getToken();
    if(token != null){
      if (defaultTargetPlatform == TargetPlatform.android) {
        await [Permission.microphone, Permission.camera].request();
      }
      print('$channelId  channel id from broadcast controller $token token before join channel with user account ${authController.firebaseUser.value!.uid}');
      await engine.joinChannelWithUserAccount(
        token,
        channelId,
        authController.firebaseUser.value!.uid,
      );
    }
  }

  addListeners() {
    engine.setEventHandler(
      RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint('joinChannelSuccess $channel $uid $elapsed');
      }, userJoined: (uid, elapsed) {
        debugPrint('userJoined $uid $elapsed');
        remoteUid.add(uid);
      }, userOffline: (uid, reason) {
        debugPrint('userOffline $uid $reason');
        remoteUid.removeWhere((element) => element == uid);
      }, leaveChannel: (stats) {
        debugPrint('leaveChannel $stats');
        remoteUid.clear();
      }, tokenPrivilegeWillExpire: (token) async {
        await getToken();
        await engine.renewToken(token);
      }),
    );
  }

  void switchCamera() {
    engine.switchCamera().then((value) {
      _switchCamera = !_switchCamera;
    }).catchError((onError) {
      if (kDebugMode) {
        print("Switch Camera $onError");
      }
    });
  }

  void onToggleMute() {
    isMuted = !isMuted;
     engine.muteLocalAudioStream(isMuted);
  }

  Future<void> chat(String text, String id) async {
    final user = authController.firebaseUser;
    try {
      String commentId = const Uuid().v1();
      await _firestore
          .collection('liveStreaming')
          .doc(id)
          .collection('comments')
          .doc(commentId)
          .set({
        'displayName': user.value!.displayName,
        'message': text,
        'uid': user.value!.uid,
        'createdAt': DateTime.now(),
        'commentId': commentId,
      });
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message!);
    }
  }

  String baseURL = "https://sportsmastro-server.herokuapp.com";
  String? token;

  Future<void> getToken() async {
    final res = await http.get(
      Uri.parse(
          '$baseURL/rtc/$channelId/pulisher/userAccount/${authController.firebaseUser.value!.uid}/'),
    );

    if (res.statusCode == 200) {
      token = res.body;
      token = jsonDecode(token!)['rtcToken'];
    } else {
      print('failed to fetch token');
    }
  }

  leaveChannel() async {
    if ('${authController.firebaseUser.value!.uid}${authController.firebaseUser.value!.displayName}' ==
        channelId) {
      await goLiveController.endLiveStream(channelId);
    } else {
      await goLiveController.updateViewCount(channelId, false);
    }
    Get.offAll(
      BottomNavigation(email: authController.firebaseUser.value!.email!),
    );
  }
}
