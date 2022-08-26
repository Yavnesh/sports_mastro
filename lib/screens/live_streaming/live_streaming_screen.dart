// import 'package:flutter/material.dart';
//
// import '../../models/activity_model.dart';
// import '../../models/live_streaming_model.dart';
// import 'package:get/get.dart';
//
// class LiveStreamingScreen extends StatelessWidget {
//   final LiveStreaming? stream;
//
//   const LiveStreamingScreen({Key? key, this.stream}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 3,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         offset: Offset(0.0, 2.0),
//                         blurRadius: 6.0,
//                       ),
//                     ],
//                   ),
//                   child: Hero(
//                     tag: stream!.imageUrl!,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(5.0),
//                       child: Image(
//                         image: NetworkImage(stream!.imageUrl!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.keyboard_arrow_down_rounded),
//                         iconSize: 25.0,
//                         color: Colors.white,
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       Row(
//                         children: <Widget>[
//                           IconButton(
//                             icon: Icon(Icons.cast_rounded),
//                             iconSize: 25.0,
//                             color: Colors.white,
//                             onPressed: () => print("cast pressed"),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.ios_share_rounded),
//                             iconSize: 25.0,
//                             color: Colors.white,
//                             onPressed: () => print("share pressed"),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.favorite_border_rounded),
//                             iconSize: 25.0,
//                             color: Colors.white,
//                             onPressed: () => print("favourite pressed"),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.settings_rounded),
//                             iconSize: 25.0,
//                             color: Colors.white,
//                             onPressed: () => print("setting pressed"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 20.0,
//                   bottom: 20.0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(2.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.sensors_rounded,
//                                     color: Colors.white,
//                                     size: 14.0,
//                                   ),
//                                   SizedBox(
//                                     width: 4.0,
//                                   ),
//                                   Text(
//                                     "LIVE",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 10.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5.0),
//                           Container(
//                             color: Colors.black45,
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Row(
//                                 children: <Widget>[
//                                   Text(
//                                     stream!.viewers.toString(),
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   SizedBox(width: 5.0),
//                                   Text(
//                                     "WATCHING",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: IconButton(
//                     icon: Icon(Icons.fullscreen_rounded),
//                     iconSize: 25.0,
//                     color: Colors.white,
//                     onPressed: () => Get.back(),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/controllers/live_streaming/go_live_controller.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/live_streaming/broadcast_controller.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../../models/live_streaming_model.dart';
import '../../widgets/chat/chat.dart';

class LiveStreamingScreen extends StatelessWidget {
  const LiveStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2  ');
    final BroadcastController broadcastController =
    Get.put(BroadcastController());
    print(broadcastController.channelId);
    AuthController authController = Get.find();
    final size = MediaQuery.of(context).size;
    print("$size ############################################");
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ElevatedButton(
              child: Text('User ',),
              onPressed:(){
                // goLiveController.endLiveStream(broadcastController.channelId);
                print(" user watiching");
              }
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Obx(() => Hero(
                        tag: "stream!.imageUrl!",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: _renderVideo(),
                        ),
                      ),),
                    ),
                    // top bar of the live streaming container
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            iconSize: 25.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.cast_rounded),
                                iconSize: 25.0,
                                color: Colors.white,
                                onPressed: () => print("cast pressed"),
                              ),
                              IconButton(
                                icon: Icon(Icons.ios_share_rounded),
                                iconSize: 25.0,
                                color: Colors.white,
                                onPressed: () => print("share pressed"),
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite_border_rounded),
                                iconSize: 25.0,
                                color: Colors.white,
                                onPressed: () => print("favourite pressed"),
                              ),
                              IconButton(
                                icon: Icon(Icons.settings_rounded),
                                iconSize: 25.0,
                                color: Colors.white,
                                onPressed: () => print("setting pressed"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // bottom bar of the live streaming container
                    Positioned(
                      left: 20.0,
                      bottom: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sensors_rounded,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "LIVE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Container(
                                color: Colors.black45,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "stream!.viewers.toString()",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "WATCHING",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.fullscreen_rounded),
                        iconSize: 25.0,
                        color: Colors.white,
                        onPressed: () => Get.back(),
                      ),
                    )
                  ],
                ),
                Expanded(child: Chat())
              ],
            ),
        ),
      ),
    );
  }

  _renderVideo() {
    final BroadcastController broadcastController =
    Get.put(BroadcastController());
    return Container(
      child: broadcastController.remoteUid.isNotEmpty
          ? kIsWeb
          ? RtcRemoteView.SurfaceView(
        uid: broadcastController.remoteUid[0],
        channelId: broadcastController.channelId,
      ) : RtcRemoteView.TextureView(
        uid: broadcastController.remoteUid[0],
        channelId: broadcastController.channelId,
      ): Container(),
    );
  }
}
