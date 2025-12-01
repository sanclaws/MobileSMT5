import 'package:flutter/material.dart';
import 'session_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    await SessionManager.logout();

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),

      body: FutureBuilder<String?>(
        future: SessionManager.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          String username = snapshot.data ?? "User";

          return Center(
            child: Text(
              "Selamat datang, $username!",
              style: const TextStyle(fontSize: 22),
            ),
          );
        },
      ),
    );
  }
}