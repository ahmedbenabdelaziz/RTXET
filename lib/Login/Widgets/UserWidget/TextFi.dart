import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TextF(String name,String cond,Icon icon)=>Container(
  padding: EdgeInsets.symmetric(horizontal: 20),
  height: 40,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFf6f7f9)
  ),
  child: TextFormField(
    keyboardType: TextInputType.emailAddress,
    validator: (text){
      if(text!.isEmpty){
        return cond;
      }
    },
    decoration: InputDecoration(
        prefixIcon: icon,
        hintText: name,
        border: InputBorder.none
    ),
  ),
);