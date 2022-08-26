import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/controllers/live_streaming/go_live_controller.dart';
import 'package:sports_gurukul/models/live_streaming_model.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/live_streaming/broadcast_controller.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../../widgets/chat/chat.dart';

class BroadcastScreen extends StatelessWidget {
  const BroadcastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BroadcastController broadcastController =
        Get.put(BroadcastController());
    AuthController authController = Get.find();
    final user = authController.firebaseUser;
    print(broadcastController.channelId);
    return WillPopScope(
      onWillPop: () async {
        print("will pop scope");
        await broadcastController.leaveChannel();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ElevatedButton(
                child: Text(
                  'End Stream',
                ),
                onPressed: () {
                  broadcastController.leaveChannel();
                }),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      _renderVideo(),
                      '${user.value!.uid}${user.value!.displayName}' ==
                              broadcastController.channelId
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    broadcastController.switchCamera();
                                  },
                                  child: Icon(Icons.cameraswitch_rounded),
                                ),
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      broadcastController.onToggleMute();
                                    },
                                    child: Icon(broadcastController.isMuted
                                        ? Icons.volume_mute_rounded
                                        : Icons.volume_up_rounded),
                                  ),
                                ),
                              ],
                            )
                          : Expanded(child: Chat())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _renderVideo() {
    BroadcastController broadcastController = Get.find();
    AuthController authController = Get.find();
    var user = authController.firebaseUser;
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: "${user.value!.uid}${user.value!.displayName}" ==
                broadcastController.channelId
            ? const RtcLocalView.SurfaceView(
                zOrderMediaOverlay: true,
                zOrderOnTop: true,
              )
            : null);
  }
}
