import 'package:formativafinal/tela2.dart';
import 'package:formativafinal/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: TelaLogin(),
  ));
}

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});

  final TextEditingController _user = TextEditingController();
  final TextEditingController _passw = TextEditingController();

  _pesquisarUsuarioSenha(BuildContext context, String usuario, String senha) async {
    String url = "http://10.109.83.12:3000/usuarios";
    
      http.Response resposta=  await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        List<dynamic> usuarios = jsonDecode(resposta.body);
        bool encontrouUsuario = false;

        for (var usuarioApi in usuarios) {
          if (usuarioApi['user'] == usuario && usuarioApi['password'] == senha) {
            encontrouUsuario = true;
            break;
          }
        }

        if (encontrouUsuario) {
          print('Login correto');
          Navigator.push(context, MaterialPageRoute(builder: (context) => Telaprincipal()));
        } else {
          print('Usuário ou senha inválidos');
          _exibirAlerta(context);
        }
      } else {
        print('Erro ao acessar a API');
        _exibirAlerta(context);
      }

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
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                        Navigator.push(context,MaterialPageRoute(builder: (context) => TelaRegister(),));
                      },
                      child: Text("Registrar"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Defina a cor do botão aqui
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String usuario = _user.text;
                        String senha = _passw.text;
                        _pesquisarUsuarioSenha(context, usuario, senha);
                      },
                      child: Text("Entrar"),
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
          title: Text("Login Incorreto"),
          content: Text("O nome de usuário ou senha está incorreto."),
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
