import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ambil argument dari halaman lain
    final args = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini adalah Halaman Utama',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // tampilkan argumen kalau ada
            if (args != null)
              Text(
                args,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // kirim argument ke halaman kedua
                Navigator.pushNamed(
                  context,
                  '/second',
                  arguments: 'Halo dari Halaman Utama!',
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.navigate_next),
                  SizedBox(width: 8),
                  Text('Pindah ke Halaman Kedua'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}