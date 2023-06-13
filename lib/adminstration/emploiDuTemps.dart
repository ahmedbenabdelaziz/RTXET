/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class TableRowData {
  List<TextEditingController> controllers = List.generate(7, (_) => TextEditingController());
}
class EmploiDuTemps extends StatefulWidget {
  const EmploiDuTemps({Key? key}) : super(key: key);

  @override
  State<EmploiDuTemps> createState() => _EmploiDuTemps();
}

class _EmploiDuTemps extends State<EmploiDuTemps> {
  late String _selectedOption;
  late String _selectedOptionn;
  late String _selectedOptionnn;
  late String _selectedOptionnnn;
  late String _selectedOptionnnnn;
  late String ensei;


  List<List<List<String>>> rows = [

  ];

  late String ma;
  late String sa;
  Future<void> getMatiere() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };


    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/matieres'),
      headers: headers,
    );
    var data = jsonDecode(response.body)['matieres'];
    if (response.statusCode == 200) {
      print(data);
      for(var ma in data){
        setState(() {
          Matieress.add(ma['nom']);
        });
      }
    } else {
      print(data);
    }
  }

  Future<void> getSalles() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };


    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/salles'),
      headers: headers,
    );
    var data = jsonDecode(response.body)['salles'];
    if (response.statusCode == 200) {
      print(data);
      for(var ma in data){
        setState(() {
          Salless.add(ma['nom']);
        });
      }
    } else {
      print(data);
    }
  }




  Future<void> ConfirmerDateEmploi() async {

    Map<String, dynamic> data = {
      'classe_id': 1,
      'seances': [
   'matiere_id=>analyse,enseignant_id=>8,salle_id=>A22,day=>lundi,start_time=>8:30:22,end_time=>10:20:00'

    ],
    };


    String jsonData = jsonEncode(data);
    try {
      final response = await http.post(
          Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_emploi'),
          headers: {
            'Authorization': 'Bearer ${token}',
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        body: jsonData,
      );

          if (response.statusCode == 200) {
        print('Données envoyées avec succès');
        print(response.body);
      } else {
            print(response.body);

          }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
    }
  }

  List<String> classe = [
    'Ingénierie',
    'Mastére',
    'L3',
    'L2',
    'L1',
  ];

  List<String> Ensei = [
    'Enseignant',
    'fawzi',
    'lotfi'
  ];
  List<String> typeclasse = [
    'Génie Logiciel',
    'Systéme Embarqué',
    'Maths',
    'Tic',
  ];

  List<String> TD = [
    'TD 1',
    'TD 2',
    'TD 3',
    'TD 4',
    'TD 5',
    'TD 6',
  ];

  List<String> Matieres = [
    'Matieres',
  ];
  List<String> Salle = [
    'Salle',
  ];

  List<String> Matieress = [
    'Matieres',
  ];
  List<String> Salless= [
    'Salle',
  ];
final _tableKey = GlobalKey();

  List<List<String>> tableContent = [];

  List<List<TextEditingController>> _controllers = [];

  List<TableRowData> tableData = [];

  @override
  void initState() {
    _selectedOption = classe[0];
    _selectedOptionn = typeclasse[0];
    _selectedOptionnn = TD[0];
    _selectedOptionnnn = Matieres[0];
    _selectedOptionnnnn = Ensei[0];
    ensei =Ensei[0];
    sa = Salle[0];
     sa=Salless[0];
    ma=Matieress[0];
    getMatiere();
    getSalles();
    _controllers = List.generate(6, (_) => List.filled(7, TextEditingController()));
    for (int i = 0; i < 6; i++) {
      tableData.add(TableRowData()..controllers = List.generate(7, (index) => TextEditingController()));
    }
    super.initState();
  }
bool _showTable=false;
  @override
  List<List<String>> rowControllers = [];
  Map<int, Map<String, String>> selectedValuesMap = {};
  TableRow _buildRow(List<String> cells, {bool isHeader = false, required int rowIndex}) {
    print(rows);
    for (int i = 0; i < cells.length; i++) {
      rowControllers.add([
        selectedValuesMap[rowIndex]?['enseignant'] ?? Ensei[1],
        selectedValuesMap[rowIndex]?['matiere'] ?? Matieress[1],
        selectedValuesMap[rowIndex]?['salle'] ?? Salless[1]
      ]);
    }

    setState(() {
      rows.add([...rowControllers]); // Convert to List<List<String>>
    });

    return TableRow(
      children: cells.asMap().entries.map((entry) {
        final index = entry.key;
        final cell = entry.value;
        final isEditable = index != 0;
        final controller = isEditable ? rowControllers[index] : null;

        return TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            width: isHeader ? 100 : 50,
            height: isHeader ? 50 : 120,
            color: isHeader ? Color(0xFF93ccdd) : index == 0 ? Color(0xFFdaedf3) : null,
            child: Center(
              child: isHeader
                  ? Text(
                cell,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
                  : isEditable
                  ? Column(
                children: [
                  SizedBox(
                    height: 33,
                    child: DropdownButton<String>(
                      value: rowControllers[index][0], // Update the index
                      items: Ensei.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          rowControllers[index][0] = value!; // Update the index
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 33,
                    child: DropdownButton<String>(
                      value: rowControllers[index][1], // Update the index
                      items: Matieress.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          rowControllers[index][1] = value!; // Update the index
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 33,
                    child: DropdownButton<String>(
                      value: rowControllers[index][2], // Update the index
                      items: Salless.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          rowControllers[index][2] = value!; // Update the index
                        });
                      },
                    ),
                  ),
                ],
              )
                  : Text(
                cell,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFff7f7fa),
      body:Container(
        child:Column(children: [
          Container(
            height: 50,
            padding:EdgeInsets.only(right:30),
            width: double.infinity,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child:Image.asset('lib/adminstration/img/téléchargement (2).png'),
                ),
                Row(
                  children: [
                    Text('ISIMM',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF26519e)),),
                    Text('_eCAMPUS',style:TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(width: 40,),
                Container(
                  width: 40,
                  height: 40,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child:Center(
                    child:Icon(Icons.dashboard,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.circular(10)
                    )
                    ,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "search..."
                    ),
                  ),
                )),
                Expanded(child:Container()),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.1),
                        ),

                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar(
                        backgroundImage:AssetImage('lib/adminstration/img/tunisie.png'),
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.05),
                            child: Icon(Icons.notifications_none,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.03),
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.03),

                            child:Icon(Icons.email_outlined,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius:20,
                          child:Image.asset('lib/ISIM_LOGO_ar.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ISIMM',style:TextStyle(fontWeight: FontWeight.bold),),
                          Text('Adminstration',style:TextStyle(color: Colors.blue),)

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                height: 530,
                width: 215,
                color:Colors.white,
                child:ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Text('Menu principal',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),

                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.black54,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.black54,fontWeight: FontWeight.bold)),
                                  Expanded(child: Container()),
                                  SizedBox(width:10,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/prof.png')),
                                SizedBox(width: 20,),
                                Text('enseignants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/etudiant-diplome.png')),
                                SizedBox(width: 20,),
                                Text('Etudiants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Extra',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                Text('Boite De Recéption',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/calendrier.png',color: Colors.black54,)),
                                SizedBox(width: 10,),
                                Text('Calendrier',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/presse-papiers.png')),
                                SizedBox(width: 10,),
                                Text('Résultats',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3d5ee1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/emploi-du-temps.png')),
                                SizedBox(width: 10,),
                                Text('Emploi Du temps',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                Text('Horaires Examens',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Text('Autre',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Rapports PFE',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('PFE BOOK',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Société',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Text('Gestion',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Rapports PFE',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('PFE BOOK',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Société',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20,right: 30,left: 30),
                width: 1050,
                height: 530,
                color: Color(0xFff7f7fa),
                child:ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Text('Emploi Du temps',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                        ,Expanded(child: Container()),
                        Text('Home   /'),
                        Text('  Emploi Du temps',style:TextStyle(color: Colors.black38),)
                      ],
                    ),
                    SizedBox(height: 15,),

                    Container(
                      padding: EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      height: 900,
                      width: 500,
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'classe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26519e),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: _selectedOption,
                                items: classe.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Section',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26519e),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: _selectedOptionn,
                                items: typeclasse.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptionn = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 15),
                              Text(
                                'TD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26519e),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: _selectedOptionnn,
                                items: TD.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptionnn = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Matiéres',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26519e),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: _selectedOptionnnn,
                                items: Matieres.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptionnnn = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Semestre',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26519e),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: _selectedOptionnnnn,
                                items: Ensei.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptionnnnn = value!;
                                  });
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              SizedBox(
                                height: 30,
                                width: 85,
                                child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      backgroundColor:Color(0xFF3d5ee1),
                                    )
                                    ,  onPressed: () {
                                  ConfirmerDateEmploi();
    List<List<String>> savedData = [];
    for (int i = 14; i < tableData.length; i++) {
    List<String> row = [];
    for (int j = 1; j < 7; j++) { // Commencer à partir de l'index 1 pour ne pas sauvegarder la première colonne (les horaires)
    row.add(tableData[i].controllers[j].text);
    }
    savedData.add(row);
    }
    print(savedData);
    }
    , child:Text('Envoyer',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Table(
                            border: TableBorder.all(),
                            key: _tableKey,
                            children: [
                              _buildRow(['Horaire', '8:30_10:00', '10:15_11:45', '12:00_13:30', '13:30_14:45', '14:45_16:15', '16:30_18:00'], isHeader: true, rowIndex: 0),
                              _buildRow(['Lundi', '', '', '', '', '', ''], rowIndex: 1),
                              _buildRow(['Mardi', '', '', '', '', '', ''], rowIndex: 2),
                              _buildRow(['Mercredi', '', '', '', '', '', ''], rowIndex: 3),
                              _buildRow(['Jeudi', '', '', '', '', '', ''], rowIndex: 4),
                              _buildRow(['Vendredi', '', '', '', '', '', ''], rowIndex: 5),
                              _buildRow(['Samedi', '', '', '', '', '', ''], rowIndex: 6),
                            ],
                          ),
    ],)
                    )

                  ],
                ),
              ),
            ],
          )
        ],),
      ),
    );

  }

}*/
