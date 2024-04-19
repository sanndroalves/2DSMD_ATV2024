import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tela4 extends StatefulWidget {
  const Tela4({Key? key}) : super(key: key);

  @override
  State<Tela4> createState() => _Tela4State();
}

class _Tela4State extends State<Tela4> {
  String url = "http://10.109.83.12:3000/opinioes";
  var minhalista;
  var opinioes = <Opiniao>[];
  

  _getdado()async{
      
    http.Response resposta=  await http.get(Uri.parse(url)); 
    var dado = jsonDecode(resposta.body) as List;

    setState(() {
      opinioes = dado.map((json) => Opiniao.fromJson(json)).toList(); 
      
    });
    print("TOMA: $opinioes");
    minhalista = Opiniao_n(dado); 
    print(minhalista.opini);

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
              "Comentários:",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 25,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _getdado();
                },
                child: Text("Gerar"),
                style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Defina a cor do botão aqui
                      ),
            ),
            SizedBox(height: 20),
            Column(
              children: opinioes.map((op) => Text("${op.materia} -> ${op.descricao}", style: TextStyle(fontSize: 18))).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class Opiniao{
  final String id;
  final String materia;
  final String descricao;
  Opiniao(this.id, this.materia, this.descricao);
  // factory será responsável por mapear o nosso json na classe produto
  factory Opiniao.fromJson(Map<String,dynamic>json){
   return Opiniao(
    json['id'],json['materia'],json['descricao']);
  }
}

class Opiniao_n{
  List opini=[]; // criando uma lista chamada prod para a classe produto_n
  Opiniao_n(this.opini); // construtor da classe produto_n
}