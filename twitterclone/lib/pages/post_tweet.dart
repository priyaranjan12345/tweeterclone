import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:twitterclone/services/firebaseservice.dart';
import 'package:twitterclone/widgets/mywidgets.dart';

TextEditingController message = TextEditingController();

class TweetPage extends StatelessWidget {
  const TweetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(160, 60),
        child: MyAppBar(),
      ),
      body: MyBody(),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.close,
          color: Colors.blue,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 18,
          ),
          child: ElevatedButton(
            onPressed: () async {
              await insertData(message.text);
              message.clear();
              Get.back();
            },
            child: const Text("Tweet"),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ProfileImage(),
          Tweet(),
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  const Tweet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.context.width * 0.78,
      height: Get.context.height * 0.6,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            maxLines: 10,
            maxLength: 280,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide.none,
              ),
              focusColor: Colors.white,
              hoverColor: Colors.white,
              hintText: "What's happening ?",
            ),
            controller: message,
          ),
        ],
      ),
    );
  }
}
