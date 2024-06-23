import 'package:flutter/material.dart';
import 'package:frontend_ad/views/appointment_pet_histories.dart';

class PetItem extends StatefulWidget {
  const PetItem({super.key});

  @override
  State<PetItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PetItem> {
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
                  backgroundImage: AssetImage('images/cat.png'),
                ),
                const SizedBox(width: 10,),
                const Expanded(
                  child: Text("Chấu Đọ")
                ),
                const Text("Mèo"),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentPetHistory()));
                }, icon: const Icon(Icons.keyboard_arrow_right, size: 40,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
