import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      primaryColor: Colors.blue[300]
    ),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
    List<List<int>> _matriz =[
      [0,0,0],
      [0,0,0],
      [0,0,0]
  ] ;

  static int pedraInicial = 1;
  int pedra = pedraInicial ;
  int _whoWon = 0;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.radiation),
            tooltip: "Resetar o jogo",
            onPressed: (){
              setState(() {
               _matriz =[
                    [0,0,0],
                    [0,0,0],
                    [0,0,0]
                ] ;
                pedra = pedraInicial ;
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
            padding: EdgeInsets.fromLTRB(5,100,5,5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                  Padding(child:linhaJogodaVelha(0), padding: EdgeInsets.only(bottom: 50),),
                  Padding(child:linhaJogodaVelha(1), padding: EdgeInsets.only(bottom: 50),),
                  Padding(child:linhaJogodaVelha(2), padding: EdgeInsets.only(bottom: 50),),
              ],
            )
          )
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
        celula(linha,0),
        celula(linha,1),
        celula(linha,2),

      ],
    );
  }
  IconData imgWhoWon(){
    switch (_whoWon) {
      case 3:
        return FontAwesomeIcons.egg;
        break;
      case -1:
        return FontAwesomeIcons.volleyballBall;
      case 1:
        return FontAwesomeIcons.cross;
      
      default:
        return FontAwesomeIcons.user;
    }
  }
  IconData imgCelula(linha,coluna){
      switch(_matriz[linha][coluna]){
        case -1:
          return FontAwesomeIcons.volleyballBall;
        break;
        case 1:
          return FontAwesomeIcons.cross;
        break;
        default:
          return FontAwesomeIcons.asterisk;
      }
  }
  Widget celula(int linha,int coluna){
    IconData  data = imgCelula(linha,coluna);
    return IconButton(
      icon: Icon(data),
      onPressed: (){
        if(_matriz[linha][coluna]!=0 || _whoWon!=0){
          return null;
        }else{
          _fazerJogada(linha,coluna);
        }
        
        }, 
      
    );
  }
  void _fazerJogada(linha,coluna){
    setState(() {
          _matriz[linha][coluna] = pedra;
          if (_vitoria(linha,coluna) == 0) {
            pedra = pedra == 1 ? -1 : 1;
          }
          
          print(_matriz);
    });
  }
  // int _preenchimento 
  //TODO:metodo para verificar o empate
  int _vitoria(linha,coluna){
    var countL = 0,countC = 0,countDP = 0,countDS = 0;
    for (var i = 0; i < 3; i++) {
      countL += _matriz[linha][i] == pedra ? 1 : 0 ;
      
    }
    
    for (var i = 0; i < 3; i++) {
      countC += _matriz[i][coluna]==pedra ? 1 : 0;
        
    }
    for (var i = 0; i < 3; i++) {
       for (var j = 0; j < 3; j++) {
         if (i == j)
            {
                countDP+= _matriz[i][j] == pedra ? 1 : 0;
            } 
            if (i == (2-j))
            {
                countDS+= _matriz[i][j] ==  pedra? 1 : 0;
                
            } 
       }
    }
    if (countL == 3 || countC == 3 || countDP == 3 || countDS == 3) {
      setState(() {
        _whoWon = pedra;  
      });
      return 1;
      
    }
    return 0;
  }
}