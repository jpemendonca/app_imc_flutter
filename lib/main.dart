// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(150, 21, 75, 82);
void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    title: 'IMC flutter',
    theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 153, 66, 22)),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController myWeight = TextEditingController();
  final TextEditingController myHeight = TextEditingController();
  final List<bool> isSelected = [true, false];
  var result = '';
  var info = '';
  String? errorTextWeight;
  String? errorTextHeight;

  void calculateImc() {
    if (myWeight.text.isEmpty) {
      setState(() {
        errorTextWeight = 'Você deve inserir um peso';
        return;
      });
    }

    if (myHeight.text.isEmpty) {
      setState(() {
        errorTextHeight = 'Você deve inserir sua altura';
        return;
      });
    } else {
      setState(() {
        var weight = double.parse(myWeight.text);
        var height = (double.parse(myHeight.text) / 100);
        var myImc = (weight / (height * height));
        result = 'Resultado: ' + myImc.toStringAsPrecision(4);
        errorTextHeight = null;
        errorTextWeight = null;
        if (myImc < 16.9) {
          info = 'Muito abaixo do peso';
        } else if (17 <= myImc && myImc <= 18.4) {
          info = 'Abaixo do peso';
        } else if (18.5 <= myImc && myImc <= 24.9) {
          info = 'Peso normal';
        } else if (25 <= myImc && myImc <= 29.9) {
          info = 'Acima do peso';
        } else if (30 <= myImc && myImc <= 34.9) {
          info = 'Obesidade grau I';
        } else if (35 <= myImc && myImc <= 40) {
          info = 'Obesidade grau II';
        } else {
          info = 'Obesidade grau III';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Calculadora IMC'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          ToggleButtons(
            fillColor: Color(0xff334f53),
            children: const <Widget>[
              Icon(
                IconData(0xe3c5, fontFamily: 'MaterialIcons'),
                size: 100,
                color: Color.fromARGB(255, 52, 157, 243),
              ),
              Icon(
                IconData(0xe261, fontFamily: 'MaterialIcons'),
                size: 100,
                color: Colors.pink,
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: myWeight,
              maxLength: 4,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                  errorText: errorTextWeight,
                  border: OutlineInputBorder(),
                  labelText: 'Seu peso aqui, em kg',
                  labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 212, 212, 212)),
                  hintText: '60',
                  hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 134, 133, 133))),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: myHeight,
              maxLength: 5,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                errorText: errorTextHeight,
                border: OutlineInputBorder(),
                labelText: 'Sua altura aqui, em cm',
                labelStyle: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 212, 212, 212)),
                hintText: '175',
                hintStyle: TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 134, 133, 133)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: calculateImc,
            child: Text(
              'Calcular',
              style: TextStyle(fontSize: 28),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 21, 75, 82)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
          ),
          SizedBox(height: 30),
          Container(
            width: 320,
            height: 200,
            child: Column(children: [
              Text(
                result,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(
                info,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ]),
          )
        ],
      ),
      backgroundColor: primaryColor,
    );
  }
}
