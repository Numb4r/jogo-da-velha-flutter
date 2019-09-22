import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.blue[300]),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<int>> _matriz = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  static int pedraInicial = 1;
  int _pedra = pedraInicial;
  int _whoWon = 0;
  IconData _crossIcon = FontAwesomeIcons.times;
  IconData _circleIcon = FontAwesomeIcons.circle;
  IconData _neutralIcon = FontAwesomeIcons.asterisk;
  IconData _drawIcon = FontAwesomeIcons.birthdayCake;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.syncAlt,
              color: Colors.grey[300],
            ),
            tooltip: "Resetar o jogo",
            onPressed: () {
              setState(() {
                _matriz = [
                  [0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]
                ];
                _pedra = pedraInicial;
                _whoWon = 0;
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            imgWhoWon(),
            size: 150,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 100, 5, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    child: linhaJogodaVelha(0),
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Padding(
                    child: linhaJogodaVelha(1),
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Padding(
                    child: linhaJogodaVelha(2),
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget linhaJogodaVelha(int linha) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        celula(linha, 0),
        celula(linha, 1),
        celula(linha, 2),
      ],
    );
  }

  IconData imgWhoWon() {
    switch (_whoWon) {
      case 3:
        return _drawIcon;
        break;
      case -1:
        return _circleIcon;
      case 1:
        return _crossIcon;

      default:
        return _neutralIcon;
    }
  }

  IconData imgCelula(linha, coluna) {
    switch (_matriz[linha][coluna]) {
      case -1:
        return _circleIcon;
        break;
      case 1:
        return _crossIcon;
        break;
      default:
        return _neutralIcon;
    }
  }

  Widget celula(int linha, int coluna) {
    IconData data = imgCelula(linha, coluna);
    return IconButton(
      icon: Icon(imgCelula(linha, coluna)),
      onPressed: () {
        if (_matriz[linha][coluna] != 0 || _whoWon != 0) {
          return null;
        } else {
          _fazerJogada(linha, coluna);
        }
      },
    );
  }

  void _fazerJogada(linha, coluna) {
    setState(() {
      _matriz[linha][coluna] = _pedra;
      _vitoria(linha, coluna);
      _pedra = _pedra == 1 ? -1 : 1;
      print(_matriz);
    });
  }

  bool _empate() {
    int count = 0;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        count += _matriz[i][j] != 0 ? 1 : 0;
      }
    }
    return count == 9 ? true : false;
  }

  bool _vitoriaLinha(linha) {
    var countL = 0;
    for (var i = 0; i < 3; i++) {
      countL += _matriz[linha][i] == _pedra ? 1 : 0;
    }
    return countL == 3 ? true : false;
  }

  bool _vitoriaColuna(coluna) {
    var countC = 0;
    for (var i = 0; i < 3; i++) {
      countC += _matriz[i][coluna] == _pedra ? 1 : 0;
    }
    return countC == 3 ? true : false;
  }

  bool _vitoriaDiagonais() {
    var countDP = 0, countDS = 0;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (i == j) {
          countDP += _matriz[i][j] == _pedra ? 1 : 0;
        }
        if (i == (2 - j)) {
          countDS += _matriz[i][j] == _pedra ? 1 : 0;
        }
      }
    }
    return countDP == 3 || countDS == 3 ? true : false;
  }

  int _vitoria(linha, coluna) {
    if (_vitoriaColuna(coluna) || _vitoriaLinha(linha) || _vitoriaDiagonais()) {
      setState(() {
        _whoWon = _pedra;
      });
      return 1;
    }
    if (_empate()) {
      setState(() {
        _whoWon = 3;
      });
      return 3;
    }
    return 0;
  }
}
