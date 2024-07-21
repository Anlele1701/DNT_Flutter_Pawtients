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
  DrugViewModel drugViewModel=DrugViewModel();
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
                          onPressed: () async {
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
                          icon: Icon(Icons.mode_edit_outlined)),
                      IconButton(
                          onPressed: () {
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
                                                onPressed: () async{
                                                  String result= await drugViewModel.deleteDrug(widget.drugItem!.id);
                                                  if(result!="null")
                                                  {
                                                    widget.onDelete!(widget.drugItem!.id);
                                                    Navigator.of(context).pop();
                                                  }
                                                  else{

                                                  }
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
                          icon: Icon(Icons.delete_outline))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
