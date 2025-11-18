import 'package:flutter/material.dart';
import 'evaluasi_1/kucing.dart';
import 'evaluasi_2/hewan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Evaluasi")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Evaluasi 1"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Evaluasi1Page()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Evaluasi 2"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Evaluasi2Page()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ EVALUASI 1 PAGE ------------------

class Evaluasi1Page extends StatelessWidget {
  const Evaluasi1Page({super.key});

  @override
  Widget build(BuildContext context) {
    Kucing kucing1 = Kucing("Lana", 3.5, "Putih");
    String pesan = kucing1.makan(200);

    return Scaffold(
      appBar: AppBar(title: const Text("Evaluasi 1")),
      body: Center(
        child: Text(
          pesan,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ------------------ EVALUASI 2 PAGE ------------------

class Evaluasi2Page extends StatefulWidget {
  const Evaluasi2Page({super.key});

  @override
  State<Evaluasi2Page> createState() => _Evaluasi2PageState();
}

class _Evaluasi2PageState extends State<Evaluasi2Page> {
  Hewan hewan = Hewan(10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Evaluasi 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Berat Hewan:",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "${hewan.berat.toStringAsFixed(1)} kg",
              style: const TextStyle(fontSize: 40, color: Colors.teal),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => hewan.makan());
                  },
                  child: const Text("Makan 🍽️"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() => hewan.lari());
                  },
                  child: const Text("Lari 🏃‍♂️"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
