import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(title: "Cálculo de IMC", home: PaginaInicialIMC()));
}

class PaginaInicialIMC extends StatefulWidget {
  @override
  _PaginaInicialIMCState createState() => _PaginaInicialIMCState();
}

class _PaginaInicialIMCState extends State<PaginaInicialIMC> {
  TextEditingController controllerPeso = new TextEditingController();
  TextEditingController controllerAltura = new TextEditingController();
  String _resultadoIMC = "Informe seus dados";

  GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();

  void _resetarDados() {
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      _resultadoIMC = "Informe seus dados";
    });
  }

  void _calcularIMC() {
    double peso = double.parse(controllerPeso.text);
    double altura = double.parse(controllerAltura.text) / 100;
    double resultado = peso / (altura * altura);

    setState(() {
      if (resultado < 18.6) {
        _resultadoIMC = "Abaixo do Peso (${resultado.toStringAsPrecision(4)})";
      } else if (resultado >= 18.6 && resultado < 24.9) {
        _resultadoIMC = "Peso Ideal (${resultado.toStringAsPrecision(4)})";
      } else if (resultado >= 24.9 && resultado < 29.9) {
        _resultadoIMC =
            "Levemente Acima do Peso (${resultado.toStringAsPrecision(4)})";
      } else if (resultado >= 29.9 && resultado < 34.9) {
        _resultadoIMC =
            "Obesidade Grau I (${resultado.toStringAsPrecision(4)})";
      } else if (resultado >= 34.9 && resultado < 39.9) {
        _resultadoIMC =
            "Obesidade Grau II (${resultado.toStringAsPrecision(4)})";
      } else if (resultado >= 40) {
        _resultadoIMC =
            "Obesidade Grau III (${resultado.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetarDados,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formularioKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: controllerPeso,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: controllerAltura,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                    padding: new EdgeInsets.all(10),
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.green,
                    onPressed: () {
                      if (_formularioKey.currentState.validate()) 
                        _calcularIMC();
                    }),
              ),
              Text(_resultadoIMC,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0))
            ],
          ),
        ),
      ),
    );
  }
}
