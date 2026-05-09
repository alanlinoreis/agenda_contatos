import 'package:flutter/material.dart';
import '../models/contato.dart';
import '../components/contato_tile.dart';
import '../components/contato_detalhes_dialog.dart';
import '../repositories/contatos_mock_repository.dart';
import 'adicionar_contato_page.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({super.key});

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  final repository = ContatosMockRepository();
  List<Contato> contatos = [];
  String busca = "";
  bool pesquisando = false;
  bool carregando = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    setState(() => carregando = true);
    try {
      final contatosCarregados = await repository.obterTodos();
      setState(() {
        contatos = contatosCarregados;
        carregando = false;
      });
    } catch (e) {
      setState(() => carregando = false);
      _mostrarErro('Erro ao carregar contatos');
    }
  }

  List<Contato> filtrados() {
    return contatos
        .where((c) => c.nome.toLowerCase().contains(busca.toLowerCase()))
        .toList();
  }

  void _adicionarContato() async {
    final novo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarContatoPage()),
    );

    if (novo != null) {
      try {
        await repository.adicionar(novo);
        await _carregarContatos();
        _mostrarSucesso('Contato adicionado com sucesso!');
      } catch (e) {
        _mostrarErro('Erro ao adicionar contato');
      }
    }
  }

  void _toggleFavorito(int indice) async {
    try {
      final contato = filtrados()[indice];
      final contatoAtualizado = contato.copyWith(favorito: !contato.favorito);
      
      // Encontrar o índice original na lista completa
      final indiceOriginal = contatos.indexOf(contato);
      await repository.atualizar(indiceOriginal, contatoAtualizado);
      
      setState(() {
        contatos[indiceOriginal] = contatoAtualizado;
      });

      _mostrarSucesso(
        contatoAtualizado.favorito
            ? "${contato.nome} adicionado aos favoritos"
            : "${contato.nome} removido dos favoritos",
      );
    } catch (e) {
      _mostrarErro('Erro ao atualizar favorito');
    }
  }

  void _abrirDetalhesContato(int indice) {
    final contato = filtrados()[indice];
    showDialog(
      context: context,
      builder: (context) => ContatoDetalhesDialog(
        contato: contato,
        onFavoritoPressed: () {
          Navigator.pop(context);
          _toggleFavorito(indice);
        },
      ),
    );
  }

  void _reordenarContatos(int oldIndex, int newIndex) async {
    try {
      if (oldIndex < newIndex) newIndex -= 1;

      setState(() {
        final contatosFiltrados = filtrados();

        // Pega os contatos pelos índices da lista filtrada
        final contatoMovido = contatosFiltrados[oldIndex];
        final contatoDestino = contatosFiltrados[newIndex];

        // Mapeia para os índices reais em `contatos`
        final indiceOriginalAntigo = contatos.indexOf(contatoMovido);
        final indiceOriginalNovo = contatos.indexOf(contatoDestino);

        // Reordena a lista original
        contatos.removeAt(indiceOriginalAntigo);
        contatos.insert(indiceOriginalNovo, contatoMovido);
      });

      // Atualizar a ordem na lista completa
      await repository.reordenar(contatos);
      _mostrarSucesso('Contatos reordenados!');
    } catch (e) {
      await _carregarContatos();
      _mostrarErro('Erro ao reordenar contatos');
    }
  }

  void _mostrarSucesso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pesquisando
            ? TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Buscar...",
                  border: InputBorder.none,
                ),
                onChanged: (v) {
                  setState(() {
                    busca = v;
                  });
                },
              )
            : const Text("Contatos"),
        actions: [
          IconButton(
            icon: Icon(pesquisando ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                pesquisando = !pesquisando;
                busca = "";
                controller.clear();
              });
            },
          )
        ],
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : contatos.isEmpty
              ? const Center(
                  child: Text("Nenhum contato cadastrado"),
                )
              : ReorderableListView(
                  onReorder: _reordenarContatos,
                  buildDefaultDragHandles: false,
                  children: List.generate(
                    filtrados().length,
                    (i) {
                      final c = filtrados()[i];
                      return Container(
                        key: ValueKey(c.nome + c.telefone),
                        child: ContatoTile(
                          index: i,
                          contato: c,
                          onFavoritoPressed: () => _toggleFavorito(i),
                          onTap: () => _abrirDetalhesContato(i),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarContato,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}