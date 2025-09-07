import 'package:flutter/material.dart';
import 'second_page.dart';

import 'package:praktikum2/detail_mahasiswa_page.dart';
import 'package:praktikum2/models/mahasiswa.dart';
import 'second_page_with_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Kasus 1: Pindah halaman tanpa data
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text("Go to Second Page"),
            ),

            // end of kasus 1

            //Kasus 2: Pindah halaman dengan data
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPageWithData(
                      nama: "Dzikri",
                      umur: 20,
                      alamat: "Bandung",
                    ),
                  ),
                );
              },
              child: Text("Berpindah dengan data"),
            ),

            //end of kasus 2

            //Kasus 3: Pindah halaman dengan object
            ElevatedButton(
              onPressed: () {
                final mhs = Mahasiswa(
                  nama: "dzikri 2",
                  umur: 21,
                  alamat: "Jakarta",
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMahasiswaPage(mhs: mhs),
                  ),
                );
              },
              child: Text("Detail Mahasiswa Object"),
            ),

            //end of kasus 3

            //Kasus 4: Panggil Activity diluar flutter
            ElevatedButton(
              onPressed: () async {
                final Uri telUri = Uri(scheme: 'tel', path: '0899999999');
                if (await canLaunchUrl(telUri)) {
                  await launchUrl(telUri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Tidak ada aplikasi Telepon di perangkat ini",
                      ),
                    ),
                  );
                }
              },
              child: const Text("Panggil Nomor"),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Gambar tersimpan di ${image.path}"),
                    ),
                  );
                }
              },
              child: const Text("Buka Kamera"),
            ),
          ],
        ),
      ),
    );
  }
}