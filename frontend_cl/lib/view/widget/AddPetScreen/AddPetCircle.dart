import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/addpetprofile_screen.dart';

class AddPetCircle extends StatefulWidget {
  AddPetCircle({super.key, this.userID = ""});
  String? userID;

  @override
  State<AddPetCircle> createState() => _AddPetCircleState();
}

class _AddPetCircleState extends State<AddPetCircle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF9B26F),
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                splashColor: const Color(0xffF48B29),
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddPetProfileScreen(
                              userID: widget.userID,
                            ))),
                customBorder: const CircleBorder(),
                child: Center(
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 2)),
                    child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            )),
        const Text("Tạo hồ sơ")
      ],
    );
  }
}
