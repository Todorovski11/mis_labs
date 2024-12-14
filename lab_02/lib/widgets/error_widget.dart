import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;

  const CustomErrorWidget({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}
