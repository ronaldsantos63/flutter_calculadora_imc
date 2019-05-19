import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _infoText = "Info";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _weightController.text = "";
    _heightController.text = "";
    _formKey.currentState.reset();
    setState(() {
      _infoText = "";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.5) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc < 34.9) {
        _infoText = "Obsidade grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc < 39.9) {
        _infoText = "Obsidade grau 2 (${imc.toStringAsPrecision(4)})";
      } else {
        _infoText = "Obsidade grau 1(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.deepPurple,
                  size: 100,
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  cursorColor: Colors.deepPurple,
                  cursorWidth: 3.0,
                  textDirection: TextDirection.rtl,
                  controller: _weightController,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      suffixText: "kg",
                      counterText: "",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      suffixStyle: TextStyle(color: Colors.deepPurple)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu PESO!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  cursorColor: Colors.deepPurple,
                  cursorWidth: 3.0,
                  textDirection: TextDirection.rtl,
                  controller: _heightController,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      suffixText: "cm",
                      counterText: "",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      suffixStyle: TextStyle(color: Colors.deepPurple)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua ALTURA!";
                    }
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  height: 70.0,
                  child: RaisedButton(
                    color: Colors.deepPurple,
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                ),
              ],
            ),
          )),
    );
  }
}
