import 'package:flutter/material.dart';
import '../models/manutencao.dart';
import '../controllers/manutencao_controller.dart';

class ManutencaoFormPage extends StatefulWidget {
  final Manutencao? manutencao;

  const ManutencaoFormPage({super.key, this.manutencao});

  @override
  _ManutencaoFormPageState createState() => _ManutencaoFormPageState();
}

class _ManutencaoFormPageState extends State<ManutencaoFormPage> {
  final controller = ManutencaoController();

  final equipamentoController = TextEditingController();
  final descricaoController = TextEditingController();
  final dataController = TextEditingController();
  final statusController = TextEditingController();
  final responsavelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.manutencao != null) {
      equipamentoController.text = widget.manutencao!.equipamento;
      descricaoController.text = widget.manutencao!.descricao;
      dataController.text = widget.manutencao!.data;
      statusController.text = widget.manutencao!.status;
      responsavelController.text = widget.manutencao!.responsavel;
    }
  }

  @override
  void dispose() {
    equipamentoController.dispose();
    descricaoController.dispose();
    dataController.dispose();
    statusController.dispose();
    responsavelController.dispose();
    super.dispose();
  }

  void salvar() async {
    final manutencao = Manutencao(
      id: widget.manutencao?.id,
      equipamento: equipamentoController.text,
      descricao: descricaoController.text,
      data: dataController.text,
      status: statusController.text,
      responsavel: responsavelController.text,
    );

    if (widget.manutencao == null) {
      await controller.addManutencao(manutencao);
    } else {
      await controller.updateManutencao(manutencao);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.manutencao == null
            ? "Nova Manutenção"
            : "Editar Manutenção"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: equipamentoController,
              decoration: const InputDecoration(labelText: "Equipamento"),
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: dataController,
              decoration: const InputDecoration(labelText: "Data"),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: "Status"),
            ),
            TextField(
              controller: responsavelController,
              decoration: const InputDecoration(labelText: "Responsável"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}