import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const PasswordGen());
}

class PasswordGen extends StatefulWidget {
  const PasswordGen({Key? key}) : super(key: key);

  @override
  State<PasswordGen> createState() => _PasswordGenState();
}

class _PasswordGenState extends State<PasswordGen> {
  bool lowerCase = true;
  bool upperCase = false;
  bool hasNumbers = false;
  bool hasSymbols = false;

  List<String> options = ["lowerCase"];

  int size = 4;
  String password = "password goes here";

  String passwordGenerator() {
    List<String> password = [];
    for (int i = 0; i < size; i++) {
      //o tamanho da senha
      //sortear uma das opcoes
      var sorteio = Random().nextInt(options.length);
      switch (options[sorteio]) {
        case "lowerCase":
          {
            password.add(String.fromCharCode((Random().nextInt(25) + 97)));
          }
          break;
        case "upperCase":
          {
            password.add(String.fromCharCode((Random().nextInt(25) + 65)));
          }
          break;
        case "hasSymbols":
          {
            password.add(String.fromCharCode((Random().nextInt(14) + 33)));
          }
          break;
        case "hasNumbers":
          {
            password.add(String.fromCharCode((Random().nextInt(10) + 48)));
          }
          break;
      }
    }
    return password.join("");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFECECEA),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      password,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SwitchListTile(
                    title: const Text("LOWER CASE"),
                    activeColor: const Color(0xFF505050),
                    value: lowerCase,
                    onChanged: (bool value) {
                      setState(() {
                        if (!value) {
                          if (options.length > 1) {
                            lowerCase = value;
                            options.remove("lowerCase");
                            password = passwordGenerator();
                          }
                        } else {
                          if (!options.contains("lowerCase")) {
                            lowerCase = value;
                            options.add("lowerCase");
                            password = passwordGenerator();
                          }
                        }
                      });
                    }), // lower case
                SwitchListTile(
                    title: const Text("UPPER CASE"),
                    activeColor: const Color(0xFF505050),
                    value: upperCase,
                    onChanged: (bool value) {
                      setState(() {
                        if (!value) {
                          if (options.length > 1) {
                            upperCase = value;
                            options.remove("upperCase");
                            password = passwordGenerator();
                          }
                        } else {
                          if (!options.contains("upperCase")) {
                            upperCase = value;
                            options.add("upperCase");
                            password = passwordGenerator();
                          }
                        }
                      });
                    }), // upper case
                SwitchListTile(
                    title: const Text("INCLUDE NUMBERS"),
                    activeColor: const Color(0xFF505050),
                    value: hasNumbers,
                    onChanged: (bool value) {
                      setState(() {
                        if (!value) {
                          if (options.length > 1) {
                            hasNumbers = value;
                            options.remove("hasNumbers");
                            password = passwordGenerator();
                          }
                        } else {
                          if (!options.contains("hasNumbers")) {
                            hasNumbers = value;
                            options.add("hasNumbers");
                            password = passwordGenerator();
                          }
                        }
                      });
                    }), // has numbers
                SwitchListTile(
                    title: const Text("INCLUDE SYMBOLS"),
                    activeColor: const Color(0xFF505050),
                    value: hasSymbols,
                    onChanged: (bool value) {
                      setState(() {
                        if (!value) {
                          if (options.length > 1) {
                            hasSymbols = value;
                            options.remove("hasSymbols");
                            password = passwordGenerator();
                          }
                        } else {
                          if (!options.contains("hasSymbols")) {
                            hasSymbols = value;
                            options.add("hasSymbols");
                            password = passwordGenerator();
                          }
                        }
                      });
                    }), // has symbols
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SIZE"),
                      Slider(
                        activeColor: const Color(0xFF505050),
                        inactiveColor: const Color(0xFFBDBDC7),
                        value: size.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            size = newValue.toInt();
                            password = passwordGenerator();
                          });
                        },
                        label: size.toString(),
                        min: 4.0,
                        max: 16.0,
                      ),
                      Text(size.toString()),
                    ],
                  ),
                ), // size slider
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          primary: const Color(0xFF505050),
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: password));
                          Fluttertoast.showToast(
                              msg: "Password copied to clipboard!",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.grey[600]);
                        },
                        child: const Text(
                          "COPY",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ), // copy button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            password = passwordGenerator();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          primary: const Color(0xFFBDBDC7),
                        ),
                        child: const Text(
                          "RESET",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ) // reset button,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
