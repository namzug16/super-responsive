
import 'package:flutter/material.dart';
import 'package:flutter_responsive_website/src/navbar.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key, required this.example}) : super(key: key);

  final String example;

  @override
  Widget build(BuildContext context) {

   Widget _getExample(String example){
     switch(example){
       case "1":
         return const SizedBox();
     }
     return const SizedBox();
   }

    return Center(
      child: Column(
        children: [
          Navbar(),
          _getExample(example),
        ],
      ),
    );
  }
}


