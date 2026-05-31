import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Variabel default awal untuk menampung data profil sesuai modul Anda
  String imgProfile = 'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
  String myDisplayName = 'User';
  String namaHero = 'superheroname';
  String moodsHero = '.....';

  @override
  Widget build(BuildContext context) {
    // PopScope menggantikan WillPopScope untuk mematikan tombol back fisik bawaan HP
    return PopScope(
      canPop: false, 
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                
                // 1. Foto Profil Lingkaran
                CircleAvatar(
                  backgroundImage: NetworkImage(imgProfile),
                  radius: 80.0,
                ),
                const SizedBox(height: 20.0),
                
                // 2. Teks Sapaan Pengguna
                Text(
                  "Helo $myDisplayName, you are $namaHero!",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                
                // 3. Teks Status Moods
                Text(
                  'Moods: $moodsHero',
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                
                // Expanded mendorong deretan ikon tombol agar berada di paling bawah layar
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Tombol Kiri: Settings Nama
                      IconButton(
                        iconSize: 35.0,
                        icon: const Icon(Icons.settings),
                        tooltip: 'Set Profile Name',
                        onPressed: () {
                          // Nanti dihubungkan ke Bagian 5
                        },
                      ),
                      // Tombol Tengah: Tambah Mood & Cari Hero
                      IconButton(
                        iconSize: 35.0,
                        icon: const Icon(Icons.person_add),
                        tooltip: 'Create Moods',
                        onPressed: () {
                          // Nanti dihubungkan ke Bagian 2 & 3
                        },
                      ),
                      // Tombol Kanan: Log Out
                      IconButton(
                        iconSize: 35.0,
                        icon: const Icon(Icons.power_settings_new),
                        tooltip: 'Log Out',
                        onPressed: () {
                          // Nanti dihubungkan ke Firebase Auth di Bagian 4
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}