import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
class Presence extends StatefulWidget {
  final String token;
  const Presence({Key? key, required this.token}) : super(key: key);

  @override
  State<Presence> createState() => _PresenceState();
}

class _PresenceState extends State<Presence> {
late String token;

  Future<Map<String, dynamic>> getAnnonce() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/liste_presence?matiere_id=1&classe_id=1'),
      headers: headers,
    );
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      return data;
    }
  }

 ConfirmerPresence() async {
  Map<String, String> headers = {
    'Authorization': 'Bearer ${token}',
    'Accept': 'application/json',

  };

  print(attendanceStatusList[0].runtimeType);
  var url = Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/confirmer_presence');
  for(var i in attendanceStatusList){

  }

  var body = {
    'sessionMatiere_id': '80',
    'date': '2022-04-02 14:33:42',
    for (var i = 0; i < attendanceStatusList.length; i++)
      'status[$i]': attendanceStatusList[i],


  };
  var response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.body);

  }





}








bool selectAll = false;

var a;



List<String?> attendanceStatusList = [];

@override
  void initState() {
    token=widget.token;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFeaeaeb),
      body:Column(
        children: [
          Container(
            color: Colors.white,
            height: 32,
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF012869),
            ),
            child: Row(
              children: [
                IconButton(onPressed:(){
                  Navigator.pop(context);
                }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                Text('Gestion Du présence',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),

              ],
            ),
          ),
          Container(
            height: 80,
              color: Color(0xFF012869)
,            child: DatePicker(
              DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: Colors.white.withOpacity(.1),
              height: 60,
              initialSelectedDate:DateTime.now(),
              dateTextStyle:TextStyle(fontWeight: FontWeight.bold,fontSize:25),
            ),
          ),

      Expanded(
        child: Container(
          child: StreamBuilder<Map<String, dynamic>>(
            stream: Stream.fromFuture(getAnnonce()),
            builder: (context, snapshot) {
              var stud = snapshot.data!['étudiants'];

              if (attendanceStatusList.isEmpty) {
                attendanceStatusList = List<String>.filled(stud.length, 'absent');
              }
              DateTime now = DateTime.now();
              DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
              String formattedDateTime = formatter.format(now);
              a=formattedDateTime;
              print(formattedDateTime);
              return Column(
                children: [
                  SizedBox(height: 10,),
              Card(
                elevation:4 ,
                child: Padding(
                  padding: const EdgeInsets.only(right: 14.0,left: 14,bottom: 14),
                  child: Row(
                  children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Text('Tp 2',style:TextStyle(fontSize: 17),),
                      SizedBox(height: 5,),
                      Text('L3 Génie Logiciel, Semestre 2',style:TextStyle(fontSize: 17),)
                      , SizedBox(height: 5,),
                      Text(formattedDateTime,style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),),
                    ],
                  ),
                    Expanded(child: Container()),
                    Checkbox(
                      value: selectAll,
                      onChanged: (value) {

                        setState(() {
                          selectAll = !selectAll;
                          if (selectAll) {
                            attendanceStatusList = List<String>.filled(stud.length, 'présent');
                          } else {
                            attendanceStatusList = List<String>.filled(stud.length, 'absent');
                          }
                        });
                      },
                    ),

                  ],),
                ),
              ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: stud.length,
                      itemBuilder: (context, id) {
                        bool isChecked = attendanceStatusList[id] == 'présent';

                        return Container(
                          margin: EdgeInsets.only(left: 18, right: 18, bottom: 8),
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(stud[id]['id'].toString()),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://192.168.1.13/ISIMM_eCampus/storage/app/public/${stud[id]['image']}"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            stud[id]['nom'] + stud[id]['prenom'],
                                            style: TextStyle(
                                              color: Color(0xFF012869),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            isChecked ? 'Présent' : 'Absent',
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        attendanceStatusList[id] = 'présent';
                                      } else {
                                        attendanceStatusList[id] = 'absent';
                                      }
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
        ],
      ),
     floatingActionButton:FloatingActionButton(
       child: Icon(Icons.send),
       onPressed:(){
         print(attendanceStatusList);
         ConfirmerPresence();
       },
     ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.message),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.notifications),label: "Home"),

        ],
      ),

    );
  }
}
