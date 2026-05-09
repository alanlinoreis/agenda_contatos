import '../models/contato.dart';

class ContatosMockRepository {
  // Mock dos contatos para testes
  static final List<Contato> _contatosMock = [
    Contato(
      nome: 'João Silva',
      telefone: '(11) 98765-4321',
      favorito: true,
    ),
    Contato(
      nome: 'Maria Santos',
      telefone: '(11) 99876-5432',
      favorito: false,
    ),
    Contato(
      nome: 'Pedro Oliveira',
      telefone: '(21) 97654-3210',
      favorito: false,
    ),
    Contato(
      nome: 'Ana Costa',
      telefone: '(31) 96543-2109',
      favorito: true,
    ),
  ];

  static List<Contato> obterContatosMock() {
    return List.from(_contatosMock);
  }

  // Métodos para simular operações com banco de dados
  Future<List<Contato>> obterTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_contatosMock);
  }

  Future<void> adicionar(Contato contato) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _contatosMock.add(contato);
  }

  Future<void> atualizar(int indice, Contato contato) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (indice >= 0 && indice < _contatosMock.length) {
      _contatosMock[indice] = contato;
    }
  }

  Future<void> reordenar(List<Contato> contatosReordenados) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _contatosMock.clear();
    _contatosMock.addAll(contatosReordenados);
  }

  Future<void> deletar(int indice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (indice >= 0 && indice < _contatosMock.length) {
      _contatosMock.removeAt(indice);
    }
  }
}
