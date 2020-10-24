import 'package:flutter/material.dart';
import 'random_words.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green[600]),
      home: RandomWords());
  }
}

