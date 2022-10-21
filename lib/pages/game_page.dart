import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';
import '../core/constants.dart';
import '../enums/player_type.dart';
import '../enums/winner_type.dart';
import '../widgets/custom_dialog.dart';
import 'configuracoes.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Colors.black54,
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(GAME_TITLE),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (_) => Configuracoes(_controller)))
                .whenComplete(() => {setState(() {})});
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  _buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => setState(() {
                _controller.resetWinCount();
              }),
              child: const Text('RESETAR CONTAGEM DE VITÓRIAS'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Placar', style: TextStyle(fontSize: 32.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_controller.nomePlayer1 ?? PLAYER1_SYMBOL} [${_controller.Player1Wins.toString()}]",
                      style: const TextStyle(fontSize: 32.0),
                    ),
                    const Text(
                      ' - ',
                      style: TextStyle(fontSize: 32.0),
                    ),
                    Text(
                      "[${_controller.Player2Wins.toString()}] ${_controller.nomePlayer2 ?? PLAYER2_SYMBOL} ",
                      style: const TextStyle(fontSize: 32.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          _buildBoard(),
          _buildPlayerMode(),
          _buildResetButton(),
        ],
      ),
    );
  }

  _buildResetButton() {
    return ElevatedButton(
      child: Text(RESET_BUTTON_LABEL, style: TextStyle(color: Colors.white),),
      onPressed: _onResetGame,
    );
  }

  _buildBoard() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: BOARD_SIZE,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: _buildTile,
      ),
    );
  }

  Widget _buildTile(context, index) {
    return GestureDetector(
      onTap: () => _onMarkTile(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: _controller.tiles[index].color,
        ),
        child: Center(
          child: Text(
            _controller.tiles[index].symbol,
            style: const TextStyle(
              fontSize: 72.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _onResetGame() {
    setState(() {
      _controller.reset();
    });
  }

  _onMarkTile(index) {
    if (!_controller.tiles[index].enable) return;

    setState(() {
      _controller.markBoardTileByIndex(index);
    });

    _checkWinner();
  }

  _checkWinner() {
    var winner = _controller.checkWinner();
    if (winner == WinnerType.none) {
      if (!_controller.hasMoves) {
        _showTiedDialog();
      } else if (_controller.isSinglePlayer! &&
          _controller.currentPlayer == PlayerType.player2) {
        final index = _controller.automaticMove();
        _onMarkTile(index);
      }
    } else {
      String symbol =
          winner == WinnerType.player1 ? PLAYER1_SYMBOL : PLAYER2_SYMBOL;
      _showWinnerDialog(symbol);
    }
  }

  _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: WIN_TITLE.replaceAll('[SYMBOL]', symbol),
          message: DIALOG_MESSAGE,
          onPressed: _onResetGame,
        );
      },
    );
  }

  _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: TIED_TITLE,
          message: DIALOG_MESSAGE,
          onPressed: _onResetGame,
        );
      },
    );
  }

  _buildPlayerMode() {
    return SwitchListTile(
      title: Text(_controller.isSinglePlayer!
          ? 'Modo Selecionado: Um Jogador'
          : 'Modo Selecionado: Dois Jogadores', style: TextStyle(color: Colors.white),),
      secondary: Icon(_controller.isSinglePlayer! ? Icons.person : Icons.group),
      value: _controller.isSinglePlayer!,
      onChanged: (value) {
        setState(() {
          _controller.isSinglePlayer = value;
        });
      },
    );
  }
}
