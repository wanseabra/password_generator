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
  bool lowerCase = false;
  bool upperCase = false;
  bool hasNumbers = false;
  bool hasSymbols = false;

  List <String> options = [];

  int size = 4;
  String password = "password goes here";

  String passwordGenerator(){
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    color: Colors.grey,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("LOWER CASE"),
                      Switch(
                          value: lowerCase,
                          onChanged: (bool value) {
                            setState(() {
                              print(value.toString());
                              lowerCase = value;
                              if (!lowerCase) {
                                options.remove("lowerCase");
                                print(options);
                              }
                              else{
                                options.add("lowerCase");
                                print(options);
                              }
                            });
                          })
                    ],
                  ),
                ), // lower case
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("UPPER CASE"),
                      Switch(
                          value: upperCase,
                          onChanged: (bool value) {
                            setState(() {
                              print(value.toString());
                              upperCase = value;
                              if (!upperCase) {
                                options.remove("upperCase");
                                print(options);
                              }
                              else{
                                options.add("upperCase");
                                print(options);
                              }
                            });
                          })
                    ],
                  ),
                ), // upper case
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("INCLUDE SYMBOLS"),
                      Switch(
                          value: hasSymbols,
                          onChanged: (bool value) {
                            setState(() {
                              print(value.toString());
                              hasSymbols = value;
                              if (!hasSymbols) {
                                options.remove("hasSymbols");
                                print(options);
                              }
                              else{
                                options.add("hasSymbols");
                                print(options);
                              }
                            });
                          })
                    ],
                  ),
                ), // include symbols
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("INCLUDE NUMBERS"),
                      Switch(
                          value: hasNumbers,
                          onChanged: (bool value) {
                            setState(() {
                              print(value.toString());
                              hasNumbers = value;
                              if (!hasNumbers) {
                                options.remove("hasNumbers");
                                print(options);
                              }
                              else{
                                options.add("hasNumbers");
                                print(options);
                              }
                            });
                          })
                    ],
                  ),
                ), // include numbers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SIZE"),
                      Slider(
                        value: size.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            size = newValue.toInt();
                          });
                        },
                        min: 4.0,
                        max: 10.0,
                      ),
                      Text(size.toString()),
                    ],
                  ),
                ), // size slider
                Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: password));
                          Fluttertoast.showToast(
                              msg: "Password copied to clipboard!",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.grey[600]);
                        },
                        child: const Text("COPY"),
                      ),
                    ), // copy button
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text("RESET"),
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

