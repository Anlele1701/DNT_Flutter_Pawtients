import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/pet_model.dart';

class PetCircle extends StatefulWidget {
  const PetCircle({Key? key, this.pet}) : super(key: key);
  final Pet? pet;

  @override
  State<PetCircle> createState() => _PetCircleState();
}

class _PetCircleState extends State<PetCircle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffDCCBEE),
            ),
            child: Center(
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255), width: 2)),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Image(
                      image: widget.pet?.loaiThuCung == "Mèo"
                          ? AssetImage('assets/images/catprofile.png')
                          : AssetImage('assets/images/dogprofile.png'),
                      width: 20,
                      height: 27),
                ),
              ),
            )),
        Text("${widget.pet?.tenThuCung}")
      ],
    );
  }
}
