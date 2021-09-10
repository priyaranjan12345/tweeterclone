import 'package:flutter/material.dart';

class ChildSearch extends StatelessWidget {
  const ChildSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("search"),
          Container(
            padding: const EdgeInsets.all(40),
            child: const TextField(),
          ),
        ],
      ),
    );
  }
}
