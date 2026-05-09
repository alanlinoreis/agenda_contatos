import 'package:flutter/material.dart';
import '../models/contato.dart';

class ContatoTile extends StatelessWidget {
  final Contato contato;
  final VoidCallback onFavoritoPressed;
  final VoidCallback onTap;
  final int index;

  const ContatoTile({
    super.key,
    required this.contato,
    required this.onFavoritoPressed,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Ícone de perfil dentro de um círculo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.blue.shade600,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contato.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contato.telefone,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Botão de favorito
              IconButton(
                icon: Icon(
                  contato.favorito ? Icons.star : Icons.star_border,
                  color: contato.favorito ? Colors.amber : Colors.grey,
                ),
                onPressed: onFavoritoPressed,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              // Handle para drag and drop
              ReorderableDragStartListener(
                index: index,
                child: Icon(
                  Icons.drag_handle,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
