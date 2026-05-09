import 'package:flutter/material.dart';
import 'pages/contatos_page.dart';

void main() {
  runApp(const AgendaContatos());
}

class AgendaContatos extends StatelessWidget {
  const AgendaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContatosPage(),
    );
  }
}