import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const JokeCard({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.purple[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
