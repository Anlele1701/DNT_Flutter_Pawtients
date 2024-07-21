import 'package:flutter/material.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:frontend_ad/views/web_views/edit_vacxin.dart';
import 'package:frontend_ad/views_models/vacxin_view_model.dart';

class VacxinItem extends StatefulWidget {
  VacxinItem({super.key, this.vacxinItem, this.onDelete});
  Vacxin? vacxinItem;
  Function(String?)? onDelete;
  @override
  State<VacxinItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<VacxinItem> {
  VacxinViewModel vacxinViewModel= VacxinViewModel();
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
                          onPressed: () async{
                            final result= await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditVacxin(
                                vacxinItem: widget.vacxinItem,
                              );
                            }));
                            if (result != null && result is Vacxin) {
                              setState(() {
                                widget.vacxinItem = result;
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
                                                  String result= await vacxinViewModel.deleteVacxin(widget.vacxinItem!.id);
                                                  if(result!="null")
                                                  {
                                                    widget.onDelete!(widget.vacxinItem!.id);
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
                          }, icon: Icon(Icons.delete_outline))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
