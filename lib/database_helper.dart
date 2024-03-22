import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'note_agile.db';
  static const int dbVersion = 1;

  static const String tableCategory = 'tableCategory';
  static const String columnId = 'id';
  static const String columnNameCategory = 'nameCategory';

  static const String tableSubCategory = 'tableSubCategory';
  static const String columnSubCategoryId = 'id';
  static const String columnNameSubCategory = 'nameSubCategory';
  static const String columnCategoryId = 'category_id';

  static const String tableLink = 'tableLink';
  static const String columnLinkId = 'id';
  static const String columnLink = 'link';
  static const String columnNameLink = 'nameLink';
  static const String columnSubCategoryIdKey = 'subCategory_id';

  // Method to open database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Method to initialize database
  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        // Create category table
        await db.execute('''
          CREATE TABLE $tableCategory (
            $columnId INTEGER PRIMARY KEY,
            $columnNameCategory TEXT
          )
        ''');

        // Create note table with foreign key constraint
        await db.execute('''
          CREATE TABLE $tableSubCategory (
            $columnSubCategoryId INTEGER PRIMARY KEY,
            $columnNameSubCategory TEXT,
            $columnCategoryId INTEGER,
            FOREIGN KEY ($columnCategoryId) REFERENCES $tableCategory($columnId)
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableLink (
            $columnLinkId INTEGER PRIMARY KEY,
            $columnLink TEXT,
            $columnCategoryId INTEGER,
            $columnNameLink TEXT,
            FOREIGN KEY ($columnCategoryId) REFERENCES $tableCategory($columnId)
            
          )
        ''');
      },
      version: dbVersion,
    );
  }

  // Method to insert a category into the database
  Future<int> insertCategory(String nameCategory) async {
    Database db = await database;
    return await db.insert(tableCategory, {columnNameCategory: nameCategory});
  }

  // Method to insert a note into the database
  Future<int> insertSubCategory(String nameSubCategory, int categoryId) async {
    Database db = await database;
    return await db.insert(tableSubCategory, {
      columnNameSubCategory: nameSubCategory,
      columnCategoryId: categoryId,
    });
  }

  Future<int> insertLink(
      String link, String nameLink, int subCategoryId) async {
    Database db = await database;
    return await db.insert(tableLink, {
      columnLink: link,
      columnNameLink: nameLink,
      columnSubCategoryId: subCategoryId
    });
  }

  // Method to retrieve all categories from the database
  Future<List<Map<String, dynamic>>> getCategories() async {
    Database db = await database;
    return await db.query(tableCategory);
  }

  // Method to retrieve all SubCategorie from the database
  Future<List<Map<String, dynamic>>> getSubCategory() async {
    Database db = await database;
    return await db.query(tableSubCategory);
  }

  Future<List<Map<String, dynamic>>> getLink() async {
    Database db = await database;
    return await db.query(tableLink);
  }

  // Method to close database
  Future<void> close() async {
    Database db = await database;
    db.close();
  }
}
