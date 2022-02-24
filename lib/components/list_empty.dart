import 'package:flutter/material.dart';

class ListEmptyMessage extends StatelessWidget {
  final String message;
  IconData? icon;
  ListEmptyMessage({required this.message, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            icon ?? Icons.hourglass_empty_outlined,
            size: 50,
            color: Colors.black45,
          )
        ],
      ),
    );
  }
}
