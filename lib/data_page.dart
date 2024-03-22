import 'package:flutter/material.dart';
import 'package:crud_coba/database_helper.dart';

class AllItemsPage extends StatefulWidget {
  @override
  _AllItemsPageState createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _subCategories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<Map<String, dynamic>> categories =
        await DatabaseHelper().getCategories();
    List<Map<String, dynamic>> subCategories =
        await DatabaseHelper().getSubCategory();
    setState(() {
      _categories = categories;
      _subCategories = subCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Kategori dan Subkategori'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Kategori:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              _buildCategoriesList(),
              SizedBox(height: 16.0),
              Text(
                'Subkategori:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              _buildSubCategoriesList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return _categories.isEmpty
        ? Text('Tidak ada kategori.')
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _categories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                    'ID: ${_categories[index]['id']}, Nama: ${_categories[index]['nameCategory']}'),
              );
            },
          );
  }

  Widget _buildSubCategoriesList() {
    return _subCategories.isEmpty
        ? Text('Tidak ada subkategori.')
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _subCategories.length,
            itemBuilder: (BuildContext context, int index) {
              final subCategory = _subCategories[index];
              final categoryName = _getCategoryName(subCategory['category_id']);
              return ListTile(
                title: Text(
                    'ID: ${subCategory['id']}, Nama: ${subCategory['nameSubCategory']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori: $categoryName'),
                  ],
                ),
              );
            },
          );
  }

  String _getCategoryName(int categoryId) {
    final category = _categories.firstWhere(
        (category) => category['id'] == categoryId,
        orElse: () => {'nameCategory': 'Unknown'});
    return category['nameCategory'];
  }
}
