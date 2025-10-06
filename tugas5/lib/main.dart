import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// --- Model Data Berita Sederhana ---
class Article {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String category;

  Article({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.category,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Berita/Artikel',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsListPage(),
    );
  }
}

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  // --- Fungsi untuk Menampilkan SnackBar ---
  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Mengalihkan ke halaman berita"),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.deepPurple.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Data Dummy untuk Daftar Berita ---
    final List<Article> articles = [
      Article(
        title: "Tren Teknologi AI Terbaru di 2024",
        subtitle:
            "Pembahasan mendalam tentang perkembangan Generative AI dan dampaknya pada industri.",
        imageUrl:
            'https://lenna.ai/wp-content/uploads/2024/06/Salinan-dari-Apa-itu-Generative-AI-Penjelasan-Manfaat-dan-Tantangannya-terhadap-Bisnis-Anda-1004x500.png',
        category: "Teknologi",
      ),
      Article(
        title: "Dampak Kenaikan Harga Pangan Global",
        subtitle:
            "Analisis faktor ekonomi yang mempengaruhi stabilitas harga kebutuhan pokok.",
        imageUrl:
            'https://www.mas-software.com/wp-content/uploads/2025/08/penyebab-fluktuasi-harga-1536x864.jpg.webp',
        category: "Ekonomi",
      ),
      Article(
        title: "Review Film Harry Potter Terbaru: Fantasi Dunia Lain",
        subtitle:
            "Ulasan jujur mengenai kualitas visual, plot, dan akting para pemain utama.",
        imageUrl:
            'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/247/2025/04/16/Film-Harry-Potter_20250416_055726_0000-2919716810.png',
        category: "Hiburan",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Artikel Terbaru',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // --- Kriteria 1: Menggunakan ListView.builder ---
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              onTap: () => _showSnackbar(context),

              // --- Kriteria 2: leading (Thumbnail Gambar) ---
              leading: SizedBox(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: article.imageUrl.isNotEmpty &&
                          article.imageUrl.startsWith('http')
                      ? Image.network(
                          article.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                size: 40, color: Colors.grey);
                          },
                        )
                      : const Icon(Icons.image,
                          size: 40, color: Colors.grey),
                ),
              ),

              // --- Kriteria 2: title (Judul Berita) ---
              title: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              // --- Kriteria 2: subtitle (Deskripsi Singkat + Kategori) ---
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "${article.category} | ${article.subtitle}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ),

              // --- Kriteria 2: trailing (Ikon Bookmark) ---
              trailing: IconButton(
                icon: const Icon(Icons.bookmark_border,
                    color: Colors.deepPurple),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Artikel '${article.title}' ditandai sebagai favorit!")),
                  );
                },
              ),

              contentPadding: const EdgeInsets.all(12.0),
            ),
          );
        },
      ),
    );
  }
}
