import 'package:flutter/material.dart';
import '../controllers/manutencao_controller.dart';
import '../models/manutencao.dart';
import 'manutencao_form_page.dart';
import '../widgets/manutencao_card.dart';

class ManutencaoListPage extends StatefulWidget {
  const ManutencaoListPage({super.key});

  @override
  _ManutencaoListPageState createState() => _ManutencaoListPageState();
}

class _ManutencaoListPageState extends State<ManutencaoListPage> {
  final controller = ManutencaoController();
  List<Manutencao> lista = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final dados = await controller.fetchManutencoes();
    setState(() {
      lista = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: const Text("Manutenções"),
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 900,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ManutencaoFormPage()),
          );
          carregarDados();
        },
        child: const Icon(Icons.add),
      ),
      body: lista.isEmpty
          ? const Center(child: Text("Nenhuma manutenção cadastrada"))
          : ListView.builder(
        itemCount: lista.length,
          itemBuilder: (context, index) {
            final m = lista[index];


            return ManutencaoCard(
              manutencao: m,
              onEdit: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ManutencaoFormPage(
                      manutencao: m,
                    ),
                  ),
                );
                carregarDados();
              },
              onDelete: () async {
                await controller.deleteManutencao(m.id!);
                carregarDados();
              },
            );
          },
      ),
    );
  }
}