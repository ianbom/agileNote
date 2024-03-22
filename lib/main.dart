import 'package:crud_coba/data_page.dart';
import 'package:crud_coba/kategori_form.dart';
import 'package:crud_coba/sub_category_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp sebagai root widget
    return MaterialApp(
      home:
          AddCategoryPage(), // Menggunakan halaman AddCategoryPage sebagai halaman utama
    );
  }
}
