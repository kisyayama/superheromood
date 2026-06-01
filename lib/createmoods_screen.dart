import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';
  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? heroName;
  String? heroImageUrl;
  bool isLoading = false;

  // FUNGSI API: Menembak data menggunakan token pribadi GitHub Kisya
  Future<void> searchSuperhero(String name) async {
    setState(() {
      isLoading = true;
    });

    // Menggunakan token pribadi milik Kisya yang valid
    final String url =
        'https://superheroapi.com/api/14ed2a61c0214da630efdb28fbc9be9b/search/$name';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['response'] == 'success') {
          setState(() {
            heroName = data['results'][0]['name'];
            heroImageUrl = data['results'][0]['image']['url'];
            isLoading = false;
          });
        } else {
          showSnackbar('Superhero tidak ditemukan!');
          setState(() => isLoading = false);
        }
      } else {
        showSnackbar('Gagal terhubung ke server API.');
        setState(() => isLoading = false);
      }
    } catch (e) {
      showSnackbar('Terjadi kesalahan jaringan.');
      setState(() => isLoading = false);
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari SuperHero')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        key: const Key(
          'Form_CreateMoods',
        ), // Key validasi sesuai standar modul tugas
        child: Column(
          children: [
            // Kolom Input Pencarian
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Superhero',
                hintText: 'Contoh: Batman, Spiderman, Iron Man',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      searchSuperhero(_searchController.text.trim());
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Tampilan Hasil
            isLoading
                ? const CircularProgressIndicator()
                : heroName != null
                ? Column(
                    children: [
                      Text(
                        'Hasil: $heroName',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      heroImageUrl != null
                          ? Image.network(
                              heroImageUrl!,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) {
                                // Mengantisipasi masalah CORS jika dijalankan di Flutter Web Chrome
                                return const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                );
                              },
                            )
                          : const SizedBox(),
                    ],
                  )
                : const Text('Silakan cari superhero kamu terlebih dahulu.'),
          ],
        ),
      ),
    );
  }
}
