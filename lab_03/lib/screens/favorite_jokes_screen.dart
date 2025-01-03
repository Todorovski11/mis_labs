import 'package:flutter/material.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteJokes;

  const FavoriteJokesScreen({super.key, required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
              child: Text('No favorite jokes yet!'),
            )
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoriteJokes[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          joke['setup'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          joke['punchline'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
