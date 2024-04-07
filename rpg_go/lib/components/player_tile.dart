import 'package:flutter/material.dart';
import 'package:rpg_go/pages/sheet_page.dart';

class PlayerTile extends StatelessWidget {
  final String playerName;
  const PlayerTile(String name, {super.key}) : playerName = name;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(66, 214, 223, 0.9),
      child: ListTile(
        leading: const Icon(
          Icons.person,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          playerName,
          style: const TextStyle(
              fontSize: 20, fontFamily: 'Revol', color: Colors.white),
        ),
        dense: false,
        onTap: () {},
        contentPadding: const EdgeInsets.all(30),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(228, 4, 53, 56)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SheetPage()));
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
