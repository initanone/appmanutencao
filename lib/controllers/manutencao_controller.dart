import '../models/manutencao.dart';
import '../database/database_helper.dart';

class ManutencaoController {
  final db = DatabaseHelper.instance;


  Future<int> addManutencao(Manutencao m) async {
    return await db.insertManutencao(m);
  }


  Future<List<Manutencao>> fetchManutencoes() async {
    return await db.getManutencoes();
  }


  Future<int> updateManutencao(Manutencao m) async {
    return await db.updateManutencao(m);
  }
  
  Future<int> deleteManutencao(int id) async {
    return await db.deleteManutencao(id);
  }
}