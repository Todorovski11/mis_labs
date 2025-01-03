import 'package:flutter/material.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  RandomJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: apiService.fetchRandomJoke(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final joke = snapshot.data!;
              return Center(
                child: Card(
                  elevation: 8,
                  color: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          joke['setup'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          joke['punchline'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(child: Text('No joke found'));
          },
        ),
      ),
    );
  }
}
