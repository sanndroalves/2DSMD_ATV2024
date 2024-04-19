import 'package:formativafinal/tela3.dart';
import 'package:formativafinal/tela4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Telaprincipal(),
  ));
}

class Telaprincipal extends StatefulWidget {
  Telaprincipal({super.key});


  

  @override
  State<Telaprincipal> createState() => _TelaprincipalState();
}

class _TelaprincipalState extends State<Telaprincipal> {
  String url = "http://10.109.83.12:3000/opinioes";
  var minhalista;
  var opinioes = <Opiniao>[];

  final TextEditingController _materiaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  
  //MÉTODO GET
  _getdado()async{
    
   http.Response resposta=  await http.get(Uri.parse(url)); 

   var dado = jsonDecode(resposta.body) as List;
   setState(() {
    opinioes = dado.map((json) => Opiniao.fromJson(json)).toList(); 
     
   });
   
   minhalista = Opiniao_n(dado); 
   print(minhalista.opini);
  
  //  print(minhalista.opini.last);
  var ultimoRegistro = minhalista.opini.last;
  }

  //MÉTODO PARA PROCURAR O UTLIMO REGISTRO
  Future<Map<String, dynamic>> _getUltimoRegistro() async {
    http.Response resposta = await http.get(Uri.parse(url)); 

    var dado = jsonDecode(resposta.body) as List;
    if (dado.isNotEmpty) {
      return dado.last;
    } else {
      return {'id': '0'}; // Retorna um ID inicial caso a API esteja vazia
    }
  }
  //MÉTODO POST
  _post() async {
    var ultimoRegistro = await _getUltimoRegistro();
    int novoId = int.parse(ultimoRegistro['id']) + 1;

    String materia = _materiaController.text;
    String descricao = _descricaoController.text;

    Map<String, dynamic> opiniao_a= {
     "id": novoId.toString(),
     "materia": materia,
     "descricao":descricao
    };

    http.post(Uri.parse(url),
      headers: <String,String>{
        'Content-type':'application/json; charset=UTF-8',
      },
    body: jsonEncode(opiniao_a),
   );
   print("Post: ${opiniao_a}");
   Navigator.push(context,MaterialPageRoute(builder: (context) => Tela3(),));
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
        centerTitle: true, 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "FeedBack",
                style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                textAlign: TextAlign.center, // alinha o texto ao centro
              ),
              Text(
                "Escreva uma opinião sobre alguma matéria da faculdade",
                style: TextStyle(
                        fontSize: 13, 
                      ),
                textAlign: TextAlign.center, // alinha o texto ao centro
              ),
              SizedBox(height: 40),
              TextField(
                controller: _materiaController,
                decoration: InputDecoration(
                  labelText: 'Matéria',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alinha os botões igualmente espaçados na linha
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_descricaoController.text != "" && _materiaController.text != "") {
                        _post();
                      } else {
                        _exibirAlerta(context);
                      }
                    },
                    child: Text("Encaminhar"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Defina a cor do botão aqui
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Tela4(),));
                    },
                    child: Text("Lista"),
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
          title: Text("Preencher Campos"),
          content: Text("Você deve preencher todos os campos."),
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

class Opiniao{
  final String id;
  final String materia;
  final String descricao;
  Opiniao(this.id, this.materia, this.descricao);
  // factory será responsável por mapear o nosso json na classe produto
  factory Opiniao.fromJson(Map<String,dynamic>json){
   return Opiniao(
    json['id'],json['descricao'],json['descricao']);
  }
}

class Opiniao_n{
  List opini=[]; // criando uma lista chamada prod para a classe produto_n
  Opiniao_n(this.opini); // construtor da classe produto_n
}