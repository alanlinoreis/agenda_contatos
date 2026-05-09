import 'package:flutter/material.dart';
import '../models/contato.dart';

class ContatoDetalhesDialog extends StatelessWidget {
  final Contato contato;
  final VoidCallback onFavoritoPressed;

  const ContatoDetalhesDialog({
    super.key,
    required this.contato,
    required this.onFavoritoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho com ícone
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Nome
              Text(
                contato.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),

              // Telefone
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.blue.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Telefone',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contato.telefone,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Status de favorito
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: contato.favorito ? Colors.amber : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    contato.favorito ? 'Favorito' : 'Adicionar aos favoritos',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Botões
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onFavoritoPressed,
                      icon: Icon(
                        contato.favorito ? Icons.star : Icons.star_border,
                      ),
                      label: Text(
                        contato.favorito ? 'Remover' : 'Favoritar',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                      ),
                      child: const Text(
                        'Fechar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
