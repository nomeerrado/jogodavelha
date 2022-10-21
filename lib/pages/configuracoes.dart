import 'package:flutter/material.dart';
import 'package:jogodavelha/controllers/game_controller.dart';

class Configuracoes extends StatelessWidget {
  final GameController controller;

  const Configuracoes(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuraçaum"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: controller.nomePlayer1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nome jogador(a) 1')),
              onChanged: (value) => controller.nomePlayer1 = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: controller.nomePlayer2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nome jogador(a) 2')),
              onChanged: (value) => controller.nomePlayer2 = value,
            ),
          ),
        ],
      ),
    );
  }
}
