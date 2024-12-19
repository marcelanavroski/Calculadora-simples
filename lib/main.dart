// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String resultado = "0";
  String operando1 = "";
  String operando2 = "";
  String operador = "";

  void _botaoPressionado(String valor) {
    setState(() {
      if (["+", "-", "*", "/"].contains(valor)) {
        operador = valor;
        operando1 = resultado;
        resultado = "0";
      } else if (valor == "=") {
        double num1 = double.parse(operando1);
        double num2 = double.parse(resultado);

        switch (operador) {
          case "+":
            resultado = (num1 + num2).toString();
            break;
          case "-":
            resultado = (num1 - num2).toString();
            break;
          case "*":
            resultado = (num1 * num2).toString();
            break;
          case "/":
            resultado = (num1 / num2).toString();
            break;
        }
        operando1 = "";
        operador = "";
      } else if (valor == "C") {
        resultado = "0";
        operando1 = "";
        operador = "";
      } else {
        if (resultado == "0") {
          resultado = valor;
        } else {
          resultado += valor;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                resultado,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              _criarLinhaBotoes(["7", "8", "9", "/"]),
              _criarLinhaBotoes(["4", "5", "6", "*"]),
              _criarLinhaBotoes(["1", "2", "3", "-"]),
              _criarLinhaBotoes(["C", "0", "=", "+"]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _criarLinhaBotoes(List<String> botoes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: botoes.map((botao) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _botaoPressionado(botao),
              child: Text(botao, style: TextStyle(fontSize: 24)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
