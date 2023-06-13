import 'package:flutter/material.dart';
class presence extends StatefulWidget {
  const presence({Key? key}) : super(key: key);
  @override
  State<presence> createState() => _presenceState();
}

class _presenceState extends State<presence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            color: Color(0xFF012869)
,            height: 33,
          ),
          Container(
            color: Color(0xFF012869),
            height: 70,
            child:Row(
              children: [
                IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
                Text('Gestion Du présence',style:TextStyle(color:Colors.white,fontSize: 25,fontWeight:FontWeight.w600),)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 110,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Text('Tp 2',style:TextStyle(fontSize: 17),),
                SizedBox(height: 5,),
                Text('L3 Génie Logiciel, Semestre 2',style:TextStyle(fontSize: 17),)
              , SizedBox(height: 5,),
                Text('Lundi 21 juin 2023',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red),),
              ],
            ),
          ),
          Container(
            height: 40,
            color:Colors.white,
            width: double.infinity,
            child:Row(
              children: [
                Container(width: 245,
                height: 50,
                color:Color(0xFF012869),
                child:Center(child: Text('Etudiant',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),)),
                ),
                VerticalDivider(
                  width: 5,
                  color: Colors.white,
                ),
                Container(width: 70,
                  height: 50,
                  color:Color(0xFF012869),
                  child:Center(child: Text('ID',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),)),
                ),
                VerticalDivider(
                  width: 5,
                  color: Colors.black,
                ),
                Container(width: 40,
                  height: 50,
                  color:Color(0xFF012869),
                  child:Center(child: Text('P/A',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 422,
              child:ListView.builder(
                  itemCount: 40,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true
                  ,itemBuilder:(context,id){
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:AssetImage('lib/chat/135397796_1171775189945124_3258220724117022209_n.jpg'),
                          ),
                          SizedBox(width: 30,),
                          Text('Ahmed Ben Abdelaziz',style:TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                          SizedBox(width: 40,),
                          Text('1',style:TextStyle(fontWeight:FontWeight.w500),),
                          SizedBox(width:30,),
                          Checkbox(value:true, onChanged:(value){})
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
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
