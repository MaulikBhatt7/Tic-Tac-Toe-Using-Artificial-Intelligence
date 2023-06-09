import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';

class GameBoardPage extends StatefulWidget {
  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  final scores = {'X': -10, 'O': 10, 'tie': 0};
  bool isWin = false;
  var board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];
  final players = ["O", "X"];
  int turn = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(24, 26, 74, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Player : X        AI : O",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 205, 58, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(104, 113, 198, 1),
                    border: Border.all(width: 2, color: Colors.black)),
                height: 300,
                width: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: customBox(board, 0, 0, turn),
                          ),
                          Expanded(
                            child: customBox(board, 0, 1, turn),
                          ),
                          Expanded(
                            child: customBox(board, 0, 2, turn),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: customBox(board, 1, 0, turn),
                          ),
                          Expanded(
                            child: customBox(board, 1, 1, turn),
                          ),
                          Expanded(
                            child: customBox(board, 1, 2, turn),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: customBox(board, 2, 0, turn),
                          ),
                          Expanded(
                            child: customBox(board, 2, 1, turn),
                          ),
                          Expanded(
                            child: customBox(board, 2, 2, turn),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              checkWin(board) != ""
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            checkWin(board) != "tie"
                                ? "AI Win!!!"
                                : "T i e !!!",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 205, 58, 1),
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    board = [
                                      ["", "", ""],
                                      ["", "", ""],
                                      ["", "", ""],
                                    ];
                                    isWin = false;
                                    turn = 1;
                                  });
                                },
                                child: Text("Replay")),
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget customBox(board, r, c, turn) {
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: !isWin
            ? () {
                setState(() {
                  if (board[r][c] == "") {
                    board[r][c] = players[turn];
                    turn = 1 - turn;
                    bestMove(board);
                  }
                });
              }
            : () {},
        child: Container(
          alignment: Alignment.center,
          child: Text(
            board[r][c].toString(),
            style: TextStyle(
                fontSize: 40,
                color: Color.fromRGBO(255, 205, 58, 1),
                fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(15, 18, 45, 1),
          ),
        ),
      ),
    );
  }

  String checkWin(dynamic board) {
    if (board[0][0] != "" &&
        board[0][0] == board[0][1] &&
        board[0][0] == board[0][2]) {
      isWin = true;
      return board[0][0];
    } else if (board[1][0] != "" &&
        board[1][0] == board[1][1] &&
        board[1][0] == board[1][2]) {
      isWin = true;
      return board[1][0];
    } else if (board[2][0] != "" &&
        board[2][0] == board[2][1] &&
        board[2][0] == board[2][2]) {
      isWin = true;
      return board[2][0];
    } else if (board[0][0] != "" &&
        board[0][0] == board[1][0] &&
        board[0][0] == board[2][0]) {
      isWin = true;
      return board[0][0];
    } else if (board[0][1] != "" &&
        board[0][1] == board[1][1] &&
        board[0][1] == board[2][1]) {
      isWin = true;
      return board[0][1];
    } else if (board[0][2] != "" &&
        board[0][2] == board[1][2] &&
        board[0][2] == board[2][2]) {
      isWin = true;
      return board[0][2];
    } else if (board[0][0] != "" &&
        board[0][0] == board[1][1] &&
        board[0][0] == board[2][2]) {
      isWin = true;
      return board[0][0];
    } else if (board[2][0] != "" &&
        board[2][0] == board[1][1] &&
        board[2][0] == board[0][2]) {
      isWin = true;
      return board[2][0];
    }
    bool flag = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          flag = false;
          break;
        }
      }
    }
    if (flag) {
      isWin = true;
      return "tie";
    }
    return "";
  }

  void bestMove(board) {
    // AI to make its turn

    bool flag = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          flag = false;
          break;
        }
      }
    }
    if (flag) {
      return;
    }
    var bestScore = -1000000000000000000;
    var move = {};
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        // Is the spot available?
        if (board[i][j] == '') {
          board[i][j] = players[0];
          var score = minimax(board, 0, false);
          board[i][j] = '';
          if (score >= bestScore) {
            bestScore = score;
            move['i'] = i;
            move['j'] = j;
          }
        }
      }
    }
    board[move['i']][move['j']] = players[0];
    turn = 1;
  }

  int minimax(board, depth, isMaximizing) {
    var result = checkWin(board);
    if (result != '') {
      return scores[result]!;
    }
    if (isMaximizing) {
      var bestScore = -1000000000000000000;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          // Is the spot available?
          if (board[i][j] == '') {
            board[i][j] = players[0];
            var score = minimax(board, depth + 1, false);
            board[i][j] = '';

            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      var bestScore = 1000000000000000000;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          // Is the spot available?
          if (board[i][j] == '') {
            board[i][j] = players[1];
            var score = minimax(board, depth + 1, true);
            board[i][j] = '';
            bestScore = min(score, bestScore);
          }
        }
      }
      isWin = false;
      return bestScore;
    }
  }
}
