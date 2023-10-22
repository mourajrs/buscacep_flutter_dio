import 'package:buscacep/pages/enter_page.dart';
import 'package:flutter/material.dart';

class BuscaCep extends StatelessWidget {
  const BuscaCep({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Busca CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EnterPage(),
    );
  }
}
