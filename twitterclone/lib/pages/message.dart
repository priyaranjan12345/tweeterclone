import 'package:flutter/material.dart';

class ChildMessage extends StatelessWidget {
  const ChildMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("message"),
          Container(
            padding: const EdgeInsets.all(40),
            child: const TextField(),
          ),
        ],
      ),
    );
  }
}
