import 'package:flutter/material.dart';
import 'package:crud_coba/database_helper.dart';
import 'package:crud_coba/data_page.dart';

class AddSubCategorie extends StatefulWidget {
  @override
  _AddSubCategorieState createState() => _AddSubCategorieState();
}

class _AddSubCategorieState extends State<AddSubCategorie> {
  final TextEditingController _nameSubCategoryController =
      TextEditingController();
  // final TextEditingController _contentController = TextEditingController();
  String? _selectedCategory;
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    List<Map<String, dynamic>> categories =
        await DatabaseHelper().getCategories();
    setState(() {
      _categories = categories;
      if (_categories.isNotEmpty) {
        _selectedCategory = _categories[0]['nameCategory'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Catatan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category['nameCategory'],
                  child: Text(category['nameCategory']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori',
              ),
            ),
            TextField(
              controller: _nameSubCategoryController,
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
            ),
            SizedBox(height: 16.0),
            // TextField(
            //   controller: _contentController,
            //   maxLines: null,
            //   keyboardType: TextInputType.multiline,
            //   decoration: InputDecoration(
            //     labelText: 'Isi Catatan',
            //   ),
            // ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addSubCategorie();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _addSubCategorie() async {
    String nameSubCategory = _nameSubCategoryController.text.trim();
    // String content = _contentController.text.trim();
    int categoryId = _categories.firstWhere(
        (category) => category['nameCategory'] == _selectedCategory)['id'];

    if (nameSubCategory.isNotEmpty) {
      await DatabaseHelper().insertSubCategory(nameSubCategory, categoryId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllItemsPage()),
      );
    } else {
      // Show error message if title or content is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Judul dan isi catatan tidak boleh kosong.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllItemsPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
