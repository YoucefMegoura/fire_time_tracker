import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  String title;
  String message;

  EmptyContent({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 32, color: Colors.black38),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 13, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
