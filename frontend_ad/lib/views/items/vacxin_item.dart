import 'package:flutter/material.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:frontend_ad/views/web_views/edit_vacxin.dart';

class VacxinItem extends StatefulWidget {
  VacxinItem({super.key, this.vacxinItem});
  Vacxin? vacxinItem;
  @override
  State<VacxinItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<VacxinItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 85,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                    // Set to 0 for square corners
                    child: widget.vacxinItem?.hinhAnh?.data != null
                        ? Image.memory(widget.vacxinItem!.hinhAnh!.data,
                            fit: BoxFit.cover)
                        : Container()),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.vacxinItem?.tenVacxin}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Product ID: ${widget.vacxinItem?.id}",
                    style: TextStyle(color: Color(0xffB5B5B5)),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditVacxin(
                                vacxinItem: widget.vacxinItem,
                              );
                            }));
                          },
                          icon: Icon(Icons.mode_edit_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.delete_outline))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
