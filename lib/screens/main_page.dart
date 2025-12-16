import 'package:flutter/material.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                // Bal oldali navbar
                Container(
                  width: 80,
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Icon(Icons.group, size: 30), // Csoportok
                      SizedBox(height: 20),
                      Icon(Icons.message, size: 30), // Üzenetek
                      SizedBox(height: 20),
                      Icon(Icons.event, size: 30), // Osztálykirándulás tervezés
                      Spacer(),
                      Icon(Icons.person, size: 30), // Profil, legalul
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                // Fő tartalom
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(child: Text("Fő tartalom")),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                // Fő tartalom
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(child: Text("Fő tartalom")),
                  ),
                ),
                // Alsó navbar
                Container(
                  height: 60,
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.group), // Csoportok
                      Icon(Icons.message), // Üzenetek
                      Icon(Icons.event), // Osztálykirándulás tervezés
                      Icon(Icons.person), // Profil
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}