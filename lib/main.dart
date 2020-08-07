import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
      TextEditingController _numeroCep = TextEditingController();
      String _mostrar = '';
    _mostrarCep( String numero) async{// como está mando algo para a web, ela tem que esperar um pouco
      String cep = numero;
      String url = 'https://viacep.com.br/ws/${cep}/json/';

      
      http.Response response; // vai requisitar ao ao servidor
      response = await http.get(url);// pegar os dados apair da url
      //print('resposta  ${response.statusCode.toString()}');
      //print('resposta  ${response.body}');// o body mostra o corpo da requisição
      
      Map<String ,dynamic>  salvarValores  = json.decode(response.body);
      String num_cep  = salvarValores['cep'];
      String rua =  salvarValores['logradouro'];
      String bairro = salvarValores['bairro'];

      print(' resposta do cep ${num_cep}   é a rua ${rua} do bairro ${bairro}');
      setState(() {
        _mostrar = ' ${num_cep}, ${rua} , ${bairro}';

      });

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('mostrar cep')
            ],
        ),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText:('digite o cep')
                          ),
                          controller: _numeroCep,
                        ),)
              ),
              RaisedButton(
                onPressed: (){
                  _mostrarCep(_numeroCep.text);
                },
                child: Text('pesquisar'),
              ),
              Padding(padding: EdgeInsets.only(left: 20),
                child:Text(_mostrar,
                  textAlign: TextAlign.left,) ,)
            ],
          ),
        )
      ),
    );
  }
}
