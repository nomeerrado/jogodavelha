import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogodavelha/enums/symbol_type.dart';

import '../core/constants.dart';
import '../core/winner_rules.dart';
import '../enums/player_type.dart';
import '../enums/winner_type.dart';
import '../models/board_tile.dart';

class GameController {
  SymbolType symbolType = SymbolType.TEXT;

  List<BoardTile> tiles = [];
  List<int> movesPlayer1 = [];
  List<int> movesPlayer2 = [];
  PlayerType? currentPlayer;
  PlayerType? lastCurrentPlayer;
  bool? isSinglePlayer;

  int Player1Wins = 0;
  int Player2Wins = 0;

  Color bgTileColor = Colors.grey;

  String? nomePlayer1;
  String? nomePlayer2;

  bool get hasMoves =>
      (movesPlayer1.length + movesPlayer2.length) != BOARD_SIZE;

  GameController() {
    isSinglePlayer = false;
    currentPlayer = PlayerType.player1;
    lastCurrentPlayer = currentPlayer;
    _initialize();
  }

  void _initialize() {
    movesPlayer1.clear();
    movesPlayer2.clear();
    tiles = List<BoardTile>.generate(
        BOARD_SIZE, (index) => BoardTile(index + 1, color: bgTileColor));
  }

  void reset() {
    if (!isSinglePlayer!) {
      if (lastCurrentPlayer == PlayerType.player1) {
        currentPlayer = PlayerType.player2;
        lastCurrentPlayer = currentPlayer;
      } else {
        currentPlayer = PlayerType.player1;
        lastCurrentPlayer = currentPlayer;
      }
    } else {
      currentPlayer = PlayerType.player1;
    }

    _initialize();
  }

  void markBoardTileByIndex(index) {
    final tile = tiles[index];
    if (currentPlayer == PlayerType.player1) {
      _markBoardTileWithPlayer1(tile);
    } else {
      _markBoardTileWithPlayer2(tile);
    }

    tile.enable = false;
  }

  void _markBoardTileWithPlayer1(BoardTile tile) {
    tile.symbol = PLAYER1_SYMBOL;
    tile.color = PLAYER1_COLOR;
    movesPlayer1.add(tile.id);
    currentPlayer = PlayerType.player2;
  }

  void _markBoardTileWithPlayer2(BoardTile tile) {
    tile.symbol = PLAYER2_SYMBOL;
    tile.color = PLAYER2_COLOR;
    movesPlayer2.add(tile.id);
    currentPlayer = PlayerType.player1;
  }

  bool _checkPlayerWinner(List<int> moves) {
    return winnerRules.any((rule) =>
        moves.contains(rule[0]) &&
        moves.contains(rule[1]) &&
        moves.contains(rule[2]));
  }

  WinnerType checkWinner() {
    if (_checkPlayerWinner(movesPlayer1)) {
      Player1Wins++;
      return WinnerType.player1;
    }
    if (_checkPlayerWinner(movesPlayer2)) {
      Player2Wins++;
      return WinnerType.player2;
    }
    return WinnerType.none;
  }

  int automaticMove() {
    var list = new List.generate(9, (i) => i + 1);
    list.removeWhere((element) => movesPlayer1.contains(element));
    list.removeWhere((element) => movesPlayer2.contains(element));

    var random = new Random();
    var index = random.nextInt(list.length - 1);
    return tiles.indexWhere((tile) => tile.id == list[index]);
  }

  void resetWinCount() {
    Player1Wins = 0;
    Player2Wins = 0;
  }
}
