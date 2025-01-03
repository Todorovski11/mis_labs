import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../services/api_services.dart';
import 'jokes_list_screen.dart';
import 'random_joke_screen.dart';
import 'favorite_jokes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<String>> jokeTypes;
  final List<Map<String, String>> favoriteJokes = [];

  @override
  void initState() {
    super.initState();

    // Fetch joke types
    jokeTypes = apiService.fetchJokeTypes();

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel',
              'Default',
              channelDescription: 'Default channel for notifications',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
        final snackBar = SnackBar(
          content: Text(message.notification!.title ?? 'New Notification'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login screen after logout
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Colorful Jokes',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoriteJokesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
            tooltip: 'View Favorite Jokes',
          ),
          IconButton(
            icon: const Icon(Icons.shuffle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
            tooltip: 'Get a random joke',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<String>>(
          future: jokeTypes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return JokeCategoryTile(
                      jokeType: snapshot.data![index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JokesListScreen(
                              type: snapshot.data![index],
                              favoriteJokes: favoriteJokes,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
            return const Center(
              child: Text(
                'No joke types found',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

class JokeCategoryTile extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeCategoryTile({
    super.key,
    required this.jokeType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.pinkAccent, Colors.deepOrangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            jokeType,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
