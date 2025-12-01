class Manutencao {
  int? id;
  String equipamento;
  String descricao;
  String data;
  String status;
  String responsavel;
  String? imagem;

  Manutencao({
    this.id,
    required this.equipamento,
    required this.descricao,
    required this.data,
    required this.status,
    required this.responsavel,
    this.imagem,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'equipamento': equipamento,
      'descricao': descricao,
      'data': data,
      'status': status,
      'responsavel': responsavel,
      'imagem': imagem,
    };
  }


  factory Manutencao.fromMap(Map<String, dynamic> map) {
    return Manutencao(
      id: map['id'],
      equipamento: map['equipamento'],
      descricao: map['descricao'],
      data: map['data'],
      status: map['status'],
      responsavel: map['responsavel'],
      imagem: map['imagem'],
    );
  }
}