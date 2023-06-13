import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ResultatEtudian extends StatefulWidget {
  const ResultatEtudian({Key? key}) : super(key: key);

  @override
  State<ResultatEtudian> createState() => _ResultatEtudianState();
}

class _ResultatEtudianState extends State<ResultatEtudian> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(height: 32,color: Colors.white,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF012869),
              ),
              child: Row(
                children: [
                  IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                  Text('Actualités',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),
                  SizedBox(width: 200,),
                  CircleAvatar(
                    backgroundImage:AssetImage('lib/students/iconacceuil/sdq.jpg'),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height:700,
                width: 500,
                child:Table(
                  border: TableBorder.all(),
                  children: [
                    BuildRow(["Matiére",'Examen','TP1','DS','M','C',],isheader: true),
                    BuildRow(["Multimedia",'16','19.75','20.00','12.54','12.40',])
                    ,   BuildRow(["Developpement personel",'A','20','4.5','13.54','13.54'])
                    ,BuildRow(['Systeme dentrprise','3.5','4.5','19.75','12.40','2.25'])
                    ,BuildRow(['Algébre','00.00','1','18','3.5','15.35'])
                    ,BuildRow(['Physique','18.25','12','04.25','16.74','5'])
                    ,BuildRow(['Chimie','3.5','13.25','0.21','18.25','3'])
                    ,BuildRow(['Systeme dentrprise','3.5','4.5','19.75','12.40','2.25'])
                    ,BuildRow(['Algébre','00.00','1','18','3.5','15.35'])
                    ,BuildRow(['Physique','18.25','12','04.25','16.74','5'])
                    ,BuildRow(['Chimie','3.5','13.25','0.21','18.25','3'])
                    ,BuildRow(['Systeme dentrprise','3.5','4.5','19.75','12.40','2.25'])
                    ,BuildRow(['Algébre','00.00','1','18','3.5','15.35'])
                    ,BuildRow(['Physique','18.25','12','04.25','16.74','5'])
                    ,BuildRow(['Chimie','3.5','13.25','0.21','18.25','3'])
                    ,BuildRow(['Systeme dentrprise','3.5','4.5','19.75','12.40','2.25'])
                    ,BuildRow(['Algébre','00.00','1','18','3.5','15.35'])
                    ,BuildRow(['Physique','18.25','12','04.25','16.74','5'])
                    ,BuildRow(['Chimie','3.5','13.25','0.21','18.25','3'])
                    ,BuildRow(['Systeme dentrprise','3.5','4.5','19.75','12.40','2.25'])
                    ,BuildRow(['Algébre','00.00','1','18','3.5','15.35'])
                    ,BuildRow(['Physique','18.25','12','04.25','16.74','5'])
                    ,BuildRow(['Chimie','3.5','13.25','0.21','18.25','3'])

                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  TableRow BuildRow(List<String> cells,{bool isheader = false})=>TableRow(
    children: cells.map((cell) {
      return Container(
        width: isheader ? 10 : 10, // taille du carré
        color: isheader ? Color(0xFF93ccdd) : cells.indexOf(cell) == 0 ? Color(0xFFdaedf3) : null,
        padding: EdgeInsets.all(5),
        child: Center(
          child:  Text(
            cell,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize:isheader?16:13,fontWeight:isheader?FontWeight.bold:FontWeight.normal,),
          ), // ajouter un Text pour afficher le texte
        ),
      );

    }).toList(),
  );

}
