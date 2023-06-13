import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Clique(String t)=> GestureDetector(
  onTap:(){

  },
  child: Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
        color: Color(0xFF0041c4),
        borderRadius: BorderRadius.circular(15)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(t,style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold))
      ],
    ),
  ),
);