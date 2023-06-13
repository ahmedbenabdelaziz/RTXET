import 'package:flutter/material.dart';
class Etudiant extends StatefulWidget {
  const Etudiant({Key? key}) : super(key: key);

  @override
  State<Etudiant> createState() => _EtudiantState();
}

class _EtudiantState extends State<Etudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Etuidiant'),
      ),
    );
  }
}
