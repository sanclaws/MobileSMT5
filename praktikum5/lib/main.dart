import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(BelajarImage());

class BelajarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: Text('Belajar menampilkan gambar')),
        // body: Image.asset('assets/images/BG MERAH KEMEJA HITAM 4x6.jpg', height: 1000, width: 300),
        appBar: AppBar(title: Text('Belajar menampilkan gambar dari internet')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Gambar dari internet (gunakan direct link gambar, bukan link hasil pencarian Google)
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThbjkcdVGfkNNFEOW9L5nbg_3nLBSgg_nhPw&s",
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              // Gambar dengan cache dan placeholder/error
              CachedNetworkImage(
                imageUrl: "https://cdn.pixabay.com/photo/2019/11/10/17/36/indonesia-4616370_1280.jpg",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Text('Gambar tidak ditemukan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}