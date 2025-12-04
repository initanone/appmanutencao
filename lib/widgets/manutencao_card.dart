import 'package:flutter/material.dart';
import '../models/manutencao.dart';

class ManutencaoCard extends StatelessWidget {
  final Manutencao manutencao;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ManutencaoCard({
    super.key,
    required this.manutencao,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    Color corCard;

    if (manutencao.status.toLowerCase() == "pendente") {
      corCard = Colors.yellow.shade200;
    } else if (manutencao.status.toLowerCase() == "concluído" ||
        manutencao.status.toLowerCase() == "concluido") {
      corCard = Colors.green.shade200;
    } else {
      corCard = Colors.white;
    }

    return GestureDetector(
      onTap: onEdit,
      child: Card(
        color: corCard,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListTile(
          title: Text(
            manutencao.equipamento,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Cidade: ${manutencao.cidade}\n"
            "Responsável: ${manutencao.responsavel}\n"
                "Data: ${manutencao.data}\n"
                "Status: ${manutencao.status}",
          ),

          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
