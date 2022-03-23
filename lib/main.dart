import 'package:flutter/material.dart';
import 'package:thesis_v01/InputSection.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Thesis Demo',
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thesis Demo'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: const Text('GET STARTED'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyForm()),
            );
          },
        ),
      ),
    );
  }
}
