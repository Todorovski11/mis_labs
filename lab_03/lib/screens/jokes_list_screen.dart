import 'package:flutter/material.dart';
import '../services/api_services.dart';

class JokesListScreen extends StatelessWidget {
  final String type;
  final List<Map<String, String>> favoriteJokes;

  const JokesListScreen({
    super.key,
    required this.type,
    required this.favoriteJokes,
  });

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final joke = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(joke['setup']),
                    subtitle: Text(joke['punchline']),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        favoriteJokes.add({
                          'setup': joke['setup'],
                          'punchline': joke['punchline'],
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to Favorites!')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No jokes found'),
          );
        },
      ),
    );
  }
}
