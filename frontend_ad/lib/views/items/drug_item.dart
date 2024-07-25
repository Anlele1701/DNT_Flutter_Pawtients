import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/views/web_views/edit_drug.dart';
import 'package:frontend_ad/views_models/drug_view_model.dart';

class DrugItem extends StatefulWidget {
  DrugItem({super.key, this.drugItem, this.onDelete});
  Drug? drugItem;
  Function(String?)? onDelete;
  @override
  State<DrugItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DrugItem> {
  DrugViewModel drugViewModel = DrugViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 0.1, offset: Offset(0.5, 0.5))]),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 85,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                    // Set to 0 for square corners
                    child: widget.drugItem?.hinhAnh?.data != null
                        ? Container(
                            child: Image.memory(
                              widget.drugItem!.hinhAnh!.data,
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
                  Text(
                    "Số lượng: ${widget.drugItem?.soLuong}",
                    style: TextStyle(color: Color(0xffB5B5B5)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditDrug(
                                drugItem: widget.drugItem,
                              );
                            }));
                            if (result != null && result is Drug) {
                              setState(() {
                                widget.drugItem = result;
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 0, 44, 241),
                                    Colors.blue
                                  ],
                                  stops: [0.2, 0.8],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                )),
                            child: Icon(Icons.edit_note_rounded,
                                size: 23, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: Center(
                                      child: Text("Có muốn xóa sản phẩm?"),
                                    ),
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  String result =
                                                      await drugViewModel
                                                          .deleteDrug(widget
                                                              .drugItem!.id);
                                                  if (result != "null") {
                                                    widget.onDelete!(
                                                        widget.drugItem!.id);
                                                    Navigator.of(context).pop();
                                                  } else {}
                                                },
                                                child: Text("Có")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Không"))
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 0, 0),
                                      Color.fromARGB(255, 255, 136, 0)
                                    ],
                                    stops: [0.2, 0.8],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  )),
                              child: Icon(
                                Icons.delete_forever_sharp,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
