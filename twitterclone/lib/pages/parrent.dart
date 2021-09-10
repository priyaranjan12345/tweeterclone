import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitterclone/controller/mycontroller.dart';
import 'package:twitterclone/pages/authpage.dart';
import 'package:twitterclone/pages/home.dart';
import 'package:twitterclone/pages/message.dart';
import 'package:twitterclone/pages/notification.dart';
import 'package:twitterclone/pages/serach.dart';
import 'package:twitterclone/services/firebaseservice.dart';
import 'package:twitterclone/widgets/mywidgets.dart';

final MyController _controller = Get.find();
var _pageController = PageController(
    initialPage: _controller.id.value, keepPage: true, viewportFraction: 1);
List<Widget> _pages = [
  const ChildHome(),
  const ChildSearch(),
  const ChildNotifications(),
  const ChildMessage(),
];

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: HomeAppBar(),
        preferredSize: Size(160, 60),
      ),
      drawer: MyDrawer(),
      body: Body(),
      bottomNavigationBar: MyNevigationBar(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        controller: _pageController,
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.6,
      iconTheme: const IconThemeData(color: Colors.blue, size: 30),
      centerTitle: true,
      title: const Logo(),
    );
  }
}

class MyNevigationBar extends StatelessWidget {
  const MyNevigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Colors.blue,
        unSelectedColor: Colors.black87,
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.search),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.notifications_outlined),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.email_outlined),
          ),
        ],
        currentIndex: _controller.id.value,
        onTap: (index) {
          _controller.id.value = index;
          _pageController.jumpToPage(_controller.id.value);
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            height: Get.context.height * 0.3,
            width: Get.context.width,
            child: DrawerHeader(
              padding: const EdgeInsets.only(
                left: 14,
                top: 12,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/dbg.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/a.jpg',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: Text(
                      myEmail(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "+91-1234567890",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.account_circle),
            title: const Text(
              "Profile",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () {},
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.settings),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () {},
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.logout),
            title: const Text(
              "Sign out",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            onTap: () async {
              MyWidgets().dialog();
              bool islogout = await logout();
              if (islogout) {
                Get.back();
                Get.offAll(const AuthPage());
              } else {
                Get.back();
                MyWidgets().dialogmsg("Error in sign out");
              }
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: const Text(
                    "Designed and Developed by : Priyaranjan Mantri",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/logoblue.png"), fit: BoxFit.cover),
      ),
    );
  }
}
