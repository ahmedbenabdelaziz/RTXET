import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
class DateEX extends StatefulWidget {
   final String token;
  const DateEX({Key? key, required this.token}) : super(key: key);

  @override
  State<DateEX> createState() => _DateEXState();
}

class _DateEXState extends State<DateEX> {
  static const IconData list_alt = IconData(0xe81b, fontFamily: 'MaterialIcons');
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
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
  ];

  Future<Map<String, dynamic>> DateExamen() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_epreuves'),
      headers: headers,
    );
    print("k");
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      return data;
    }
  }
  late String token;
@override
  void initState() {
    token=widget.token;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
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
                Text('Date Des Examens',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),
                SizedBox(width: 110,),

              ],
            ),
          ),
          Container(
            height: 340,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset:Offset(4,4)
                )
              ]
            ),
            child:TableCalendar(

              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                selectedTextStyle: TextStyle().copyWith(color: Colors.blue),

              ),
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<Map<String,dynamic>>(
                stream:Stream.fromFuture(DateExamen()),
                builder:(context,AsyncSnapshot<Map<String,dynamic>> snapshot) {

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                  var data =snapshot.data;
                  List<dynamic> epreuve = data!['epreuves'];
                  print(epreuve);
                  return ListView.builder(
                      itemCount: epreuve.length,
                      itemBuilder:(context,id){
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 15, bottom: 15),
                          padding: EdgeInsets.only(left: 3, right: 15),
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: id >= 0 && id < list.length ? list[id] : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        epreuve[id]['startTime'].substring(0, epreuve[id]['startTime'].length - 3),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Text(
                                        epreuve[id]['endTime'].substring(0, epreuve[id]['endTime'].length - 3),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  color: Color(0xFF012869),
                                  thickness: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        epreuve[id]['matiere']['nom'],
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month, size: 15,),
                                          SizedBox(width: 5,),
                                          Text(
                                            epreuve[id]['date'],
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Row(
                                  children: [
                                    Image.asset('lib/ResultatEtudiant/broche-de-localisation.png', height: 15, width: 15,),
                                    SizedBox(width: 8,),
                                    Text(epreuve[id]['salle']['nom']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );

                      });}
                }
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
