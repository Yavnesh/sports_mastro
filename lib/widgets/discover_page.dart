import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sports_gurukul/controllers/auth/auth_controller.dart';
import 'package:sports_gurukul/screens/live_streaming/live_streaming_screen.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/live_streaming/broadcast_controller.dart';
import '../controllers/live_streaming/go_live_controller.dart';
import '../models/live_streaming_model.dart';
import '../screens/broadcast/broadcast_screen.dart';

class DiscoverPage extends StatelessWidget {
  GoLiveController goLiveController = Get.find();
  BroadcastController broadcastController = Get.find();

  void _fetchData(BuildContext context, LiveStreaming streaming) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    await goLiveController.updateViewCount(streaming.channelId!, true);
    broadcastController.channelId = streaming.channelId.toString();
    broadcastController.isBroadcaster = false;
    await broadcastController.initEngine();

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 3));
    print("going to live streaming screen");
    Get.to(() => const LiveStreamingScreen());
    // Close the dialog programmatically
    print("fetch data function for live streaming ran completely");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Discover',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Stack(children: [
          Container(
            height: 300.0,
            child: StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('liveStreaming')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    LiveStreaming streaming =
                        LiveStreaming.fromMap(snapshot.data.docs[index].data());
                    print(streaming);
                    print("#########3");
                    return GestureDetector(
                      onTap: () async {
                        _fetchData(context, streaming);

                      },
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: 310.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                height: 120.0,
                                width: 300.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 40,
                                              height: 40,
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                // border: Border.all(width: 3, color: secondary),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        streaming.imageUrl!),
                                                    // image: NetworkImage(schoolLists[index]['logoText']),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        streaming.title!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert_rounded,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    streaming.displayName!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        letterSpacing: .3),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "Started ${timeago.format(streaming.startedAt.toDate())}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        letterSpacing: .3),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0.0, 4.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: snapshot.data.docs[index]['imageUrl'],
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        height: 180.0,
                                        width: 280.0,
                                        image: NetworkImage(snapshot
                                            .data.docs[index]['imageUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    top: 10.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
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
                                  ),
                                  Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Container(
                                      color: Colors.black26,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot
                                                  .data.docs[index]['viewers']
                                                  .toString(),
                                              style: const TextStyle(
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
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ],
    );
  }
}
