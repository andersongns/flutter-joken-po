import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  static const PEDRA = 'pedra';
  static const PAPEL = 'papel';
  static const TESOURA = 'tesoura';

  var _score = {
    'win': 0,
    'loss': 0,
  };

  var _images = [
    {'key': 'padrao', 'url': 'images/padrao.png'},
    {'key': PEDRA, 'url': 'images/pedra.png'},
    {'key': PAPEL, 'url': 'images/papel.png'},
    {'key': TESOURA, 'url': 'images/tesoura.png'},
  ];

  var _result = 'Nenhuma opção selecionada';

  var _randomItem = 0;

  void setResult(String tapBy) {
    var message = '';

    var randomNumber = generateRandomNumber();
    var randomChoose = _images[randomNumber]['key'];

    // Loss
    if (tapBy == PEDRA && randomChoose == PAPEL ||
        tapBy == PAPEL && randomChoose == TESOURA ||
        tapBy == TESOURA && randomChoose == PEDRA) {
      message = 'você perdeu :(';
      setState(() {
        this._score['loss'] += 1;
      });
    } // Win
    else if (tapBy == PEDRA && randomChoose == TESOURA ||
        tapBy == TESOURA && randomChoose == PAPEL ||
        tapBy == PAPEL && randomChoose == PEDRA) {
      message = 'Parabéns, você ganhou! :)';
      setState(() {
        this._score['win'] += 1;
      });
    } else {
      message = 'Empate! :|';
    }

    setState(() {
      this._result = message;
    });
  }

  int generateRandomNumber() {
    setState(() {
      this._randomItem = Random().nextInt(3) + 1;
    });
    return this._randomItem;
  }

  Widget imageCustom(String imagePath) {
    return Image.asset(
      imagePath,
      height: 100,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JokenPo'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Text(
                  'Pontuação',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Win: ${_score['win']} Loss: ${_score['loss']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Text(
                  'Escolha do app',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              imageCustom(_images[_randomItem]['url']),
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: imageCustom('images/pedra.png'),
                      onTap: () => setResult(PEDRA)),
                  GestureDetector(
                      child: imageCustom('images/papel.png'),
                      onTap: () => setResult(PAPEL)),
                  GestureDetector(
                      child: imageCustom('images/tesoura.png'),
                      onTap: () => setResult(TESOURA)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
