import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/a.jpg',
          ),
        ),
      ),
    );
  }
}

class MyWidgets {
  void dialog() {
    Get.defaultDialog(
      // barrierDismissible: false,
      content: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CircularProgressIndicator(),
            
            Text("Loading..."),
          ],
        ),
      ),
    );
  }

  void dialogmsg(String msg) {
    Get.defaultDialog(
        content: Center(
          child: Text(msg),
        ),
        onConfirm: () {
          Get.back();
        },
        barrierDismissible: false,
        textConfirm: "ok",
        confirmTextColor: Colors.white);
  }
}
