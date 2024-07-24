import 'package:flutter/material.dart';
import 'package:frontend_ad/views/pets.dart';

class CustomerItem extends StatefulWidget {
  const CustomerItem({super.key});

  @override
  State<CustomerItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomerItem> {
  String a="hello";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 0.1, offset: Offset(0.5, 0.5))]),
      padding: const EdgeInsets.fromLTRB(10,15,10,15),
      margin: const EdgeInsets.fromLTRB(16,10,16,10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 45,
              child: const CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage('images/personal.png',),
              ),
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
            flex:8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("Nguyễn Trịnh",style: TextStyle(fontSize: 18.5),)
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    GestureDetector(
                                onTap: () async {
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  // height: 30,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(255, 0, 44, 241),
                                      Colors.blue
                                    ],
                                    stops: [0.2,0.8],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    )
                                  ),
                                  child: Icon(Icons.edit_note_rounded,size: 23,color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 8,),
                              GestureDetector(
                                onTap: () async {
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  // height: 30,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(255, 255, 0, 0),
                                Color.fromARGB(255, 255, 136, 0)
                                    ],
                                    stops: [0.2,0.8],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    )
                                  ),
                                    child: Icon(Icons.delete_forever_sharp, color: Colors.white,)
                                ),
                              ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex:2,
            child: IconButton(onPressed: (){
              showModalBottomSheet(context: context, builder: (BuildContext context){
                return Pets();
              });
            }, icon: const Icon(Icons.keyboard_arrow_right, size: 35,)),
          )
        ],
      ),
    );
  }
}
