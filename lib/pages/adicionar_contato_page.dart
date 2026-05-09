import 'package:flutter/material.dart';
import '../models/contato.dart';

class AdicionarContatoPage extends StatefulWidget {
  const AdicionarContatoPage({super.key});

  @override
  State<AdicionarContatoPage> createState() => _AdicionarContatoPageState();
}

class _AdicionarContatoPageState extends State<AdicionarContatoPage> {
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Contato")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nome é obrigatório";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: "Telefone",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Telefone é obrigatório";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _salvarContato,
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvarContato() {
    if (_formKey.currentState!.validate()) {
      final novoContato = Contato(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        favorito: false,
      );
      Navigator.pop(context, novoContato);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }
}
