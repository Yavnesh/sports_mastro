import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/screens/go_live/go_live_screen.dart';

import '../../controllers/bottom_navigation/bottom_navigation_controller.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/liked/liked_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/subscription/subscription_screen.dart';

class BottomNavigation extends StatelessWidget {
  final String email;
  const BottomNavigation({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController bottomNavigationController =
        Get.put(BottomNavigationController(), permanent: false);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            bottomNavigationMenu(context, bottomNavigationController),
        body: Obx(
          () => IndexedStack(
            index: bottomNavigationController.currentIndex.value,
            children: [
              HomeScreen(email: email,),
              const LikedScreen(),
              GoLiveScreen(),
              const SubscriptionScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationMenu(
      BuildContext context, bottomNavigationController) {
    return Obx(
      () => BottomNavigationBar(
        onTap: bottomNavigationController.changeCurrentIndex,
        selectedItemColor: Colors.white,
        unselectedFontSize: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_location_rounded,
              color: Colors.white,
            ),
            label: "Discover",
            // activeIcon: Icon(Icons.my_location_rounded, color: Colors.black,)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              label: "Liked"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.live_tv_rounded,
                color: Colors.white,
              ),
              label: "Go Live"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.subscriptions_outlined,
                color: Colors.white,
              ),
              label: "Subscriptions"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              label: "You"),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavigationController.currentIndex.value,
        backgroundColor: Colors.black,
      ),
    );
  }
}
