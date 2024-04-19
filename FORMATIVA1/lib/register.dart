import 'package:formativafinal/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: TelaRegister(),
  ));
}

class TelaRegister extends StatelessWidget {
  TelaRegister({super.key});
  String url = "http://10.109.83.12:3000/usuarios";

  final TextEditingController _user = TextEditingController();
  final TextEditingController _passw = TextEditingController();

  _post(BuildContext context) async {

    String userNovo = _user.text;
    String senhaNova = _passw.text;

    Map<String, dynamic> user_a= {
     "user": userNovo,
     "password":senhaNova
    };

    http.post(Uri.parse(url),
      headers: <String,String>{
        'Content-type':'application/json; charset=UTF-8',
      },
    body: jsonEncode(user_a),
   );
   print("Post: ${user_a}");
   _exibirAlerta(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOPSOLID",
          textAlign: TextAlign.center, // alinha o texto ao centro
        ),
        backgroundColor: Colors.red,
        centerTitle: true, // centraliza o título
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Registrar",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Adicione as informações do novo usuário",
                style: TextStyle(
                        fontSize: 14, 
                      ),
                textAlign: TextAlign.center, // alinha o texto ao centro
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Digite seu nome",
                  border: OutlineInputBorder(),
                ),
                controller: _user,
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite sua senha",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                obscuringCharacter: '*',
                controller: _passw,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alinha os botões igualmente espaçados na linha
                children: [
                    ElevatedButton(
                      onPressed: () {
                        if(_user.text != "" && _passw.text != ""){
                          _post(context);
                        }else{
                          _exibirAlerta2(context);
                        }
                        
                      },
                      child: Text("Registrar"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Defina a cor do botão aqui
                      ),
                    ),   
                ],
              ),
            ],   
          ),
        ),
      ),
    );
  }

  void _exibirAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registro"),
          content: Text("Registrado com sucesso! Vá até login para logar com usuário."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _exibirAlerta2(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registro"),
            content: Text("Preencha todos os campos."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

}

class User_n{
  List userN=[]; // criando uma lista chamada prod para a classe produto_n
  User_n(this.userN); // construtor da classe produto_n
}