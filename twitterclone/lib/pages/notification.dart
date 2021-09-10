import 'package:flutter/material.dart';



class ChildNotifications extends StatefulWidget {
  const ChildNotifications({ Key key }) : super(key: key);

  @override
  _ChildNotificationsState createState() => _ChildNotificationsState();
}

class _ChildNotificationsState extends State<ChildNotifications> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("notification"),
          Container(
            padding: const EdgeInsets.all(40),
            child: const TextField(),
          ),
        ],
      ),
    );
  }
}
