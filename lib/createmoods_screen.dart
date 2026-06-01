// lib/createmoods_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/herodata.dart'; // Mengimport model herodata.dart sesuai modul

class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';
  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  // Mengubah method getData() sesuai poin 10 & 12 di modul
  Future<HeroData> getData() async {
    final response = await http.get(
      Uri.parse(
        'https://www.superheroapi.com/api.php/14ed2a61c0214da630efdb28fbc9be9b/search/batman',
      ),
    );

    if (response.statusCode == 200) {
      // Mengembalikan objek HeroData hasil decode JSON (Poin 12)
      return HeroData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load HeroData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari SuperHero')),
      // Menggunakan FutureBuilder sesuai poin 14 & 19 di modul
      body: FutureBuilder<HeroData>(
        future: getData(), // Mengarah ke fungsi getData() (Poin 16)
        builder: (context, AsyncSnapshot<HeroData> snapshot) {
          // Validasi jika data dari API sudah masuk (Poin 20)
          if (snapshot.hasData) {
            // Mereturn ListView.builder sesuai poin 21-25 di modul
            return ListView.builder(
              itemCount: snapshot
                  .data
                  ?.results
                  ?.length, // Mengambil panjang array results (Poin 22)
              itemBuilder: (context, index) {
                // Menyimpan data per baris berdasarkan index ke variabel heroesData (Poin 24)
                var heroesData = snapshot.data!.results![index];

                return Column(
                  children: [
                    InkWell(
                      onTap:
                          null, // Diberi null terlebih dahulu sesuai poin 26 di modul
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          height: 300.0,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Menampilkan gambar superhero dari properti img (Poin 25)
                              heroesData.img != null
                                  ? Image.network(
                                      heroesData.img!,
                                      width: 150,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.broken_image, size: 50),
                              // Menampilkan nama superhero dari properti name (Poin 25)
                              Text(
                                heroesData.name!,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            // Menampilkan indikator loading jika data belum siap (Poin 27)
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Menambahkan komponen bottomSheet di Scaffold sesuai poin 28 di modul
      bottomSheet: Card(
        child: ListTile(
          leading: const Text(
            'Moods',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          title: const TextField(),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
