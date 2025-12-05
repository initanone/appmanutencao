import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/manutencao.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('manutencoes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeTables,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE manutencoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        equipamento TEXT NOT NULL,
        descricao TEXT NOT NULL,
        data TEXT NOT NULL,
        status TEXT NOT NULL,
        responsavel TEXT NOT NULL,
        cidade TEXT,
        problemaRelatado TEXT,
        imagem TEXT
             
      )
    ''');
  }
  Future<void> _upgradeTables(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE manutencoes ADD COLUMN imagem TEXT;");
    }
    if (oldVersion < 3) {
      await db.execute("ALTER TABLE manutencoes ADD COLUMN cidade TEXT;");
      await db.execute("ALTER TABLE manutencoes ADD COLUMN problemaRelatado TEXT;");
    }
  }

  Future<int> insertManutencao(Manutencao m) async {
    final db = await instance.database;
    return await db.insert('manutencoes', m.toMap());
  }

  Future<List<Manutencao>> getManutencoes() async {
    final db = await instance.database;
    final result = await db.query('manutencoes', orderBy: 'id DESC');
    return result.map((map) => Manutencao.fromMap(map)).toList();
  }

  Future<int> updateManutencao(Manutencao m) async {
    final db = await instance.database;
    return await db.update(
      'manutencoes',
      m.toMap(),
      where: 'id = ?',
      whereArgs: [m.id],
    );
  }

  Future<int> deleteManutencao(int id) async {
    final db = await instance.database;
    return await db.delete(
      'manutencoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  }

