import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rpg_go/components/text_field.dart';
import 'package:rpg_go/pages/home_revival.dart';
import 'package:rpg_go/pages/sign_up.dart';
import 'package:rpg_go/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });
  User? user;
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(35, 37, 38, 1),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: (Column(
              children: [
                const SizedBox(height: 50),
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: const BorderRadius.all(
                          Radius.circular(20)), // raio dos cantos
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // cor da sombra
                          spreadRadius: 1, // raio de espalhamento
                          blurRadius: 0.5, // raio de desfoque
                          offset: const Offset(0, 1), // deslocamento da sombra
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/logo.png')),
                const SizedBox(height: 50),
                const Text('Welcome to RPG:GO!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Revol')),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0), // Adiciona padding de 16 pixels à esquerda
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MyTextField(controller: _controllerName),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      left: 20.0), // Adiciona padding de 16 pixels à esquerda
                  child: const Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MyTextField(controller: _controllerPassword),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 3),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: const Text('Não tenho Conta',
                              style: TextStyle(color: Colors.black))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120, top: 3),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (await loginUser(_controllerName.text,
                                _controllerPassword.text)) {
                              print("EBA");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeRevival(user)));
                            } else {
                              print("ERRO");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Login Failed'),
                                    content: const Text(
                                        'Invalid username or password.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Login',
                              style: TextStyle(color: Colors.black))),
                    )
                  ],
                )
              ],
            )),
          )),
        ));
  }

  Future<bool> loginUser(String name, String password) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['API_URL']!}user/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      print(response.body);
      user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Requisition Failed - Login.');
    }
  }
}
