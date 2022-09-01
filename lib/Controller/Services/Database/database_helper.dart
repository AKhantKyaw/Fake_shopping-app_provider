import 'package:shopping_app_with_provider/Model/datamodel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String cardTable = 'card_table';
  String colId = 'id';
  String colProductName = 'productname';
  String colInitialPrice = 'initialprice';
  String colProductPrice = 'productprice';
  String colQuality = 'quality';
  String colColor = "color";
  String colimage = 'image';
  String colcount = 'count';
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      path + "cart.db",
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $cardTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colProductName TEXT NOT NULL, $colInitialPrice INTEGER NOT NULL,$colProductPrice  INTEGER NOT NULL,$colQuality TEXT NOT NULL,$colimage TEXT NOT NULL,$colColor INTEGER NOT NULL,$colcount INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertCart(Cart cart) async {
    int result = 0;
    final Database database = await initializedDB();
    result = await database.insert(cardTable, cart.toMap());
    return result;
  }

  Future<List<Cart>> retrieveCart() async {
    final Database database = await initializedDB();
    final List<Map<String, Object?>> quaryresult =
        await database.query(cardTable);
    print(quaryresult);
    return quaryresult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    final Database database = await initializedDB();
    final data =
        await database.delete(cardTable, where: 'id = ?', whereArgs: [id]);

    return data;
  }

  Future<int> updatecount(Cart cart) async {
    final Database database = await initializedDB();
    return database.update(cardTable, cart.qualityMap(),
        where: 'id = ?', whereArgs: [cart.id]);
  }
  Future deletedatabase() async {
    final Database database = await initializedDB();
    database.delete(cardTable);
  }
}
