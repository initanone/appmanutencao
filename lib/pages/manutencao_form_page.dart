import 'package:flutter/material.dart';
import '../models/manutencao.dart';
import '../controllers/manutencao_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker picker = ImagePicker();
  XFile? imagemSelecionada;

  String gerarDataAtual() {
    final agora = DateTime.now();
    return "${agora.day.toString().padLeft(2, '0')}/"
        "${agora.month.toString().padLeft(2, '0')}/"
        "${agora.year}";
  }
  @override
  void initState() {
    super.initState();

    if (widget.manutencao != null) {
      // Modo edição
      equipamentoController.text = widget.manutencao!.equipamento;
      descricaoController.text = widget.manutencao!.descricao;
      dataController.text = widget.manutencao!.data;
      statusController.text = widget.manutencao!.status;
      responsavelController.text = widget.manutencao!.responsavel;

      if (widget.manutencao!.imagem != null) {
        imagemSelecionada = XFile(widget.manutencao!.imagem!);
      }

    } else {
      // Nova manutenção → gera automaticamente
      dataController.text = gerarDataAtual();     // <<< DATA AUTOMÁTICA
      statusController.text = "Pendente";         // <<< STATUS AUTOMÁTICO
    }
  }
  Future<void> escolherImagem() async {
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);
    if (imagem != null) { setState(() { imagemSelecionada = imagem;
    });
    }
  }


  @override
  void dispose() {
    equipamentoController.dispose();
    descricaoController.dispose();
    dataController.dispose();
    responsavelController.dispose();
    super.dispose();
  }


  void salvar() async {
    final manutencao = Manutencao(
      id: widget.manutencao?.id,
      equipamento: equipamentoController.text,
      descricao: descricaoController.text,
      status: widget.manutencao?.status ?? "Pendente",
      data: dataController.text,
      responsavel: responsavelController.text,
      imagem: imagemSelecionada?.path,
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
              readOnly: true,
              decoration: const InputDecoration(labelText: "Data"),
            ),

            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: "Status"),
            ),

            TextField(
              controller: responsavelController,
              decoration: const InputDecoration(labelText: "Responsável"),
            ),const SizedBox(height: 20),
            Text("Imagem do Equipamento", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            if (imagemSelecionada != null)
              Image.file(
                File(imagemSelecionada!.path),
                height: 150,
              ),

            TextButton.icon(
              onPressed: escolherImagem,
              icon: const Icon(Icons.image),
              label: const Text("Selecionar imagem"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text("Salvar"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                final manutencao = Manutencao(
                  id: widget.manutencao?.id,
                  equipamento: equipamentoController.text,
                  descricao: descricaoController.text,
                  data: dataController.text,
                  status: "Concluído", // ← altera aqui
                  responsavel: responsavelController.text,
                  imagem: imagemSelecionada?.path,
                );

                await controller.updateManutencao(manutencao);

                Navigator.pop(context);
              },
              child: const Text("Concluir Manutenção"),
            ),
          ],
        ),
      ),
    );
  }
}