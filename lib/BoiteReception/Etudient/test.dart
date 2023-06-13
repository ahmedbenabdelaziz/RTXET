import 'package:flutter/material.dart';
class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFbcc8ef),
      body:Column(
        children: [
          Container(
            height: 33,
            color: Colors.white,
          ),
          Container(
            height: 100,
            width: double.infinity,
            child:Row(
              children: [
                IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back)),
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 25,
                  backgroundImage:AssetImage('lib/ISIM_LOGO_ar.png'),
                ),
                SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Administration',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 5,),
                    Text('Connecté...',style:TextStyle(color: Colors.green),)
                  ],
                ),
                Expanded(child: Container()),
                
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                color:Color(0xFFdcdefb),
              ),
              child:Column(
                children: [
                  Expanded(
                    child: Container(
                    ),
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 13,right: 20,left: 20),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.file_copy_outlined),
                          SizedBox(width: 5,),
                          Expanded(child: TextFormField(
                            decoration:InputDecoration(
                              hintText: "Ecrire ici..",
                              border: InputBorder.none
                            ),
                          )),
                          IconButton(onPressed:(){}, icon: Icon(Icons.send))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
