import 'package:flutter/material.dart';

class Cat extends StatelessWidget{
  build(context){
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png'
    );
    
    //return Image.asset('lib\src\QwhZRyL.png');
  }
}