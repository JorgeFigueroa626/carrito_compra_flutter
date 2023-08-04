import 'package:flutter/material.dart';

class OtraPagina extends StatefulWidget {
  const OtraPagina({super.key});

  @override
  State<OtraPagina> createState() => _OtraPaginaState();
}

class _OtraPaginaState extends State<OtraPagina> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Otra pagina",
          style: TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }
}
