import 'package:flutter/material.dart';
import '../controllers/manutencao_controller.dart';
import '../models/manutencao.dart';
import 'manutencao_form_page.dart';

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
        title: const Text("Manutenções"),
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

          return ListTile(
            title: Text(m.equipamento),
            subtitle: Text(m.descricao),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await controller.deleteManutencao(m.id!);
                carregarDados();
              },
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ManutencaoFormPage(manutencao: m),
                ),
              );
              carregarDados();
            },
          );
        },
      ),
    );
  }
}