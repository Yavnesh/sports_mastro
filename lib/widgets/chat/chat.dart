import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/live_streaming/broadcast_controller.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);
  BroadcastController broadcastController = Get.find();
  TextEditingController? chatController;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    final user = authController.firebaseUser;
    final channelId = broadcastController.channelId;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('liveStreaming')
                  .doc(channelId)
                  .collection('comments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      snapshot.data.docs[index]['displayName'],
                      style: TextStyle(
                          color: snapshot.data.docs[index]['uid']! ==
                                  user.value!.uid
                              ? Colors.red
                              : Colors.black),
                    ),
                    subtitle: Text(
                      snapshot.data.docs[index]['message'],
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: chatController,
            onSubmitted: (val){
              print("chat submitted${val}");
                broadcastController.chat(val, channelId);
            },

          )
        ],
      ),
    );
  }
}
