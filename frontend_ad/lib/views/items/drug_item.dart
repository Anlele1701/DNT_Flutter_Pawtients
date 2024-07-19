import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/views/web_views/edit_drug.dart';

class DrugItem extends StatefulWidget {
  DrugItem({super.key, this.drugItem});
  Drug? drugItem;
  @override
  State<DrugItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DrugItem> {
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
                    child: widget.drugItem?.hinhAnh?.data != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.memory(
                              widget.drugItem!.hinhAnh!.data,
                              fit: BoxFit.cover,
                            ),
                          )
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
                    "${widget.drugItem?.tenThuoc}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Product ID: ${widget.drugItem?.id}",
                    style: TextStyle(color: Color(0xffB5B5B5)),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditDrug(
                                drugItem: widget.drugItem,
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
