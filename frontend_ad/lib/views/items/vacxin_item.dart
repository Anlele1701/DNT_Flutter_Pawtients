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
  VacxinViewModel vacxinViewModel = VacxinViewModel();
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
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(context,
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
                        SizedBox(width: 10,),
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
                                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  String result =
                                                      await vacxinViewModel
                                                          .deleteVacxin(widget
                                                              .vacxinItem!.id);
                                                  if (result != "null") {
                                                    widget.onDelete!(
                                                        widget.vacxinItem!.id);
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
