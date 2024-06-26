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
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.fromLTRB(10,15,10,15),
            margin: const EdgeInsets.fromLTRB(16,10,16,10),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  backgroundImage: AssetImage('images/personal.png'),
                ),
                const SizedBox(width: 10,),
                const Expanded(
                  child: Text("Nguyễn Trịnh")
                ),
                IconButton(onPressed: (){
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return Pets();
                  });
                }, icon: const Icon(Icons.keyboard_arrow_right, size: 40,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
