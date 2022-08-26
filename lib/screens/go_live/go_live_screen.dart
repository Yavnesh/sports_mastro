import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_gurukul/controllers/live_streaming/broadcast_controller.dart';
import 'package:sports_gurukul/controllers/live_streaming/go_live_controller.dart';
import 'package:get/get.dart';
import '../broadcast/broadcast_screen.dart';

class GoLiveScreen extends StatelessWidget {
  GoLiveScreen({Key? key}) : super(key: key);

  final _titleController = TextEditingController();
  final GoLiveController goLiveController = Get.put(GoLiveController());
  final BroadcastController broadcastController =
      Get.put(BroadcastController());

  void _fetchData(BuildContext context) async {
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

    String channelId =
        await goLiveController.startLiveStream(_titleController.text);
    if (channelId.isNotEmpty) {
      Get.snackbar('Success', 'LiveStream has started successfully!!');
      broadcastController.isBroadcaster = true;
      broadcastController.channelId = channelId;
      broadcastController.initEngine();
    }

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 3));
    print("going to broadcast screen");
    Get.to(() => const BroadcastScreen());
    // Close the dialog programmatically
    print("fetch data function ran completely");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 30.0,
                ),
                child: Obx(
                  () => goLiveController.selectedImagePath == ''
                      ? GestureDetector(
                          onTap: () async {
                            Get.bottomSheet(bottomSheet());
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.05),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select your thumbnail',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            Get.bottomSheet(bottomSheet());
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Image.file(
                                File(goLiveController.selectedImagePath.value)),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    )),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () async {
                _fetchData(context);
              },
              child: const Text('Go Live!'),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 180.0,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Choose Thumbnail',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  goLiveController.getImage(ImageSource.gallery);
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.image_rounded,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 80.0,
              ),
              InkWell(
                onTap: () {
                  goLiveController.getImage(ImageSource.camera);
                  Get.back();
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.camera,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
