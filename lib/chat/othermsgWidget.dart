import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class OtherMsgWidget extends StatelessWidget {
  final String msg;
   OtherMsgWidget({Key? key, required this.msg}) : super(key: key);
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints:BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 80
        ),
        child: Container(
          padding: EdgeInsets.only(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child:Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child:Image.asset('lib/Enseignant/imgprof/Capture d’écran 2023-05-28 190421.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(left: 8,top: 10,right: 10),
                  height: 50,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomRight:Radius.circular(20)),
                    color: Color(0xFFe4e6eb),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg,style:TextStyle(color: Colors.black,fontWeight:FontWeight.w400,),),
                      SizedBox(height: 2,),
                      Text(formattedTime,style:TextStyle(color: Colors.grey,fontSize:10),),
                      SizedBox(height: 10,)       ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
