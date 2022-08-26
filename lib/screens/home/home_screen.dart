import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/controllers/auth/auth_controller.dart';
import 'package:sports_gurukul/widgets/recommended_page.dart';
import 'package:sports_gurukul/widgets/your_category_page.dart';

import '../../controllers/live_streaming/broadcast_controller.dart';
import '../../widgets/discover_page.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  HomeScreen({Key? key, required this.email }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(email),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(
                        Icons.cast,
                        color: Colors.black,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.black,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: GestureDetector(
                        onTap: (){
                          AuthController().signOut();
                        },
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            DiscoverPage(),
            const SizedBox(height: 20.0),
            const YourCategoriesPage(),
            const SizedBox(height: 20.0),
            const RecommendedPage(),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}
