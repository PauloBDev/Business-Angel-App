import 'package:flutter/material.dart';

class AngelPage extends StatefulWidget {
  var data;
  AngelPage(this.data, {super.key});

  @override
  State<AngelPage> createState() => _AngelPageState();
}

class _AngelPageState extends State<AngelPage> {
  @override
  Widget build(BuildContext context) {
    return Text('Angel page');
  }
}
