class Contato {
  String nome;
  String telefone;
  bool favorito;

  Contato({
    required this.nome,
    required this.telefone,
    this.favorito = false,
  });

  Contato copyWith({
    String? nome,
    String? telefone,
    bool? favorito,
  }) {
    return Contato(
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      favorito: favorito ?? this.favorito,
    );
  }
}
