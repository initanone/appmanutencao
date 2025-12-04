class Manutencao {
  int? id;
  String equipamento;
  String descricao;
  String data;
  String status;
  String responsavel;
  String? imagem;
  String cidade;
  String problemaRelatado;

  Manutencao({
    this.id,
    required this.equipamento,
    required this.descricao,
    required this.data,
    required this.status,
    required this.responsavel,
    this.imagem,
    required this.cidade,
    required this.problemaRelatado,
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
      'cidade': cidade,
      'problemaRelatado': problemaRelatado,
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
      cidade: map['cidade'],
      problemaRelatado: map['problemaRelatado'],
    );
  }
}