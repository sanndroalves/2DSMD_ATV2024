import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tela3 extends StatefulWidget {
  const Tela3({Key? key}) : super(key: key);

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
  String url = "http://10.109.83.12:3000/opinioes";
  late Map<String, dynamic> ultimoRegistro = {'id': '0', 'materia': 'N/A', 'descricao': 'N/A'};

  @override
  void initState() {
    super.initState();
    _carregarUltimoRegistro();
  }

  Future<void> _carregarUltimoRegistro() async {
    http.Response resposta = await http.get(Uri.parse(url));
    var dados = jsonDecode(resposta.body) as List;
    if (dados.isNotEmpty) {
      setState(() {
        ultimoRegistro = dados.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOPSOLID",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        centerTitle: true, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seu comentário:",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "ID: ${ultimoRegistro['id']}",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "Matéria: ${ultimoRegistro['materia']}",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "Descrição: ${ultimoRegistro['descricao']}",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
