import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class resulEtudi extends StatefulWidget {
  final String token;
  const resulEtudi({Key? key, required this.token}) : super(key: key);

  @override
  State<resulEtudi> createState() => _resulEtudiState();
}

class _resulEtudiState extends State<resulEtudi> {
  late String token;
  Future<Map<String, dynamic>> ResExamen() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };
    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/mes_resultats'),
      headers: headers,
    );
    print("k");
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      print(data);
      return data;
    }
  }
  int i =0;
  List<Color> list =[
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
    Color(0xFFeeebff),
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
    Color(0xFFeeebff),
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
    Color(0xFFeeebff),
  ];

  @override
  void initState() {
    token=widget.token;
    ResExamen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(height: 32,color: Colors.white,),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF012869),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150))
            ),
            height: 110,
            child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                        Text('Espace Résultats',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),

                      ],
                    ),
                    Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Semestre  1',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('Semestre 2',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
         SizedBox(height: 40,),
         SingleChildScrollView(
         scrollDirection: Axis.horizontal
         ,child: Container(
             height: 565,
             width: 500,
             padding: EdgeInsets.symmetric(horizontal: 20),
             child:ListView(
               shrinkWrap: true,
           scrollDirection: Axis.vertical,
           children: [
             Row(
               children: [
                 Container(
                     width: 156
                 ,child: Text("Matiere",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),)),
                 Container(
                     width: 50
                     ,child: Text('DS',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),)),
                 Container(
                     width: 50,
                     child: Text("TP",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),)),
                 Container(
                     width: 85
                     ,child: Text("Examen",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),)),
                 Container(
                     width: 70,
                     child: Text("M",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),))
,                 Text("C",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869)),)

               ],),
             Container(
               height: 567,
               width: double.infinity,
               child: StreamBuilder<Map<String,dynamic>>(
                 stream:Stream.fromFuture(ResExamen()),
                 builder:(context,AsyncSnapshot <Map<String,dynamic>> snapshot) {
                   if (!snapshot.hasData) {
                     return Center(child: CircularProgressIndicator());
                   } else if (snapshot.hasError) {
                     return Text("${snapshot.error}");
                   } else {
                  List<dynamic> result = snapshot.data!['resultats'];
                   return  ListView.builder(
                       itemCount: result.length
                       ,itemBuilder:(context,id){
                     i++;
                     print(i);
                     return Container(
                       margin: EdgeInsets.symmetric(horizontal: 2),
                       height: 60,
                       color:i%2==0?Colors.blue.withOpacity(0.04):Colors.white,
                       child: Row(
                         children: [
                           Container(
                               width: 150
                               ,child: Text(result[id]['matiere']['nom'],style:TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF012869)),)),
                           Container(
                               width: 50,
                               child: Text(result[id]['note_TD'].toString())),
                           Container(
                           width: 60,
                           child: Text(result[id]['note_DS'].toString())),
                           Container(
                               width: 70,
                               child: Text(result[id]['note_Examen'].toString())),
                           Container(
                               width: 65,
                              child: Text(result[id]['moyenne'].toString())),
                           Container(
                               child: Text(result[id]['credit'].toString()))
                         ],
                       ),
                     )  ;
                   });}
                 }
               ),
             ),
           ],
             ),
           ),
         )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUi()));
          },icon:Icon(Icons.message)),label: "chat"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Screen()));
          },icon:Icon(Icons.info_outline)),label: "About"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: 'f', nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
          },icon:Icon(Icons.settings)),label: "settings"),

        ],
      ),

    );
  }
}
