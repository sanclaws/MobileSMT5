import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ambil argument yang dikirim dari halaman sebelumnya
    final args = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Kedua')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tampilkan argumen kalau ada
            if (args != null)
              Text(
                args,
                style: const TextStyle(fontSize: 18, color: Colors.purple),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/',
                  arguments: 'Halo dari Halaman Kedua!',
                );
              },
              child: const Text('Kirim Pesan ke Halaman Utama'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third', arguments: 'Pesan dari Halaman Kedua');
              },
              child: const Text('Ke Halaman Ketiga'),
            ),
          ],
        ),
      ),
    );
  }
}