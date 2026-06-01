import 'package:flutter/material.dart';
import 'main_screen.dart'; // Jangan panik kalau ini garis merah, karena filenya belum kita buat
import 'createmoods_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Mood',
      debugShowCheckedModeBanner:
          false, // Menghilangkan tulisan debug di pojok kanan atas aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Mengaktifkan desain visual modern
      ),
      // Halaman pertama yang akan otomatis terbuka saat aplikasi dinyalakan
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        CreateMoodsScreen.id: (context) => const CreateMoodsScreen(),
      },
    );
  }
}
