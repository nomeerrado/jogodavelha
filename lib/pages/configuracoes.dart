import 'package:flutter/material.dart';
import 'package:jogodavelha/controllers/game_controller.dart';
import 'package:jogodavelha/enums/symbol_type.dart';

class Configuracoes extends StatelessWidget {
  final GameController controller;

  const Configuracoes(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuraçaum"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: controller.nomePlayer1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nome jogador(a) 1')),
              onChanged: (value) => controller.nomePlayer1 = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: controller.nomePlayer2,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nome jogador(a) 2')),
              onChanged: (value) => controller.nomePlayer2 = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField(
              value: controller.symbolType,
              items: [
                DropdownMenuItem(
                  value: SymbolType.TEXT,
                  onTap: (() => controller.symbolType = SymbolType.TEXT),
                  child: const Text('Texto (X e O)'),
                ),
                DropdownMenuItem(
                  value: SymbolType.IMG,
                  onTap: (() => controller.symbolType = SymbolType.IMG),
                  child: const Text('Imagem'),
                ),
              ],
              onChanged: (i) => {},
            ),
          ),
        ],
      ),
    );
  }
}
