import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const Notify({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id)),
    );
  }
}
