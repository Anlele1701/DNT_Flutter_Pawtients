import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:frontend_ad/views/items/drug_item.dart';
import 'package:frontend_ad/views/items/vacxin_item.dart';
import 'package:frontend_ad/views/web_views/create_drug.dart';
import 'package:frontend_ad/views/web_views/create_vacxin.dart';
import 'package:frontend_ad/views_models/drug_view_model.dart';
import 'package:frontend_ad/views_models/vacxin_view_model.dart';

class Drugs extends StatefulWidget {
  const Drugs({super.key});

  @override
  State<Drugs> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Drugs> {
  int skip = 0;
  final int limit = 6;
  final ScrollController controller = ScrollController();
  String? cateChoose = "Thuốc";
  final List<String> listCate = ["Thuốc", "Vacxin"];
  DrugViewModel drugViewModel = DrugViewModel();
  VacxinViewModel vacxinViewModel = VacxinViewModel();
  List<dynamic>? listDrug = [];
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    fetchData(skip, limit);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          skip += limit;
          isLoadingMore = true;
        });
        fetchData(skip, limit);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> fetchData(int skip, int limit) async {
    List<dynamic>? newList = [];
    if (cateChoose == "Thuốc")
      newList = await drugViewModel.getDrugList(skip, limit);
    else
      newList = await vacxinViewModel.getVacxinList(skip, limit);
    if (newList != null && newList.isNotEmpty) {
      setState(() {
        listDrug!.addAll(newList!);
        isLoadingMore = false;
      });
    } else {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          listDrug!.clear();
          skip = 0;
          return fetchData(0, limit);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                      )),
                  Text(
                    "Sản phẩm",
                    style: TextStyle(fontSize: 25),
                  ),
                  IconButton(
                    onPressed: () {
                      if (cateChoose == "Vacxin") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateVacxin()));
                      } else
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateDrug()));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 35,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(color: (Colors.grey)),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  value: cateChoose,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      skip = 0;
                      cateChoose = newValue;
                      listDrug!.clear();
                    });
                    fetchData(skip, limit);
                  },
                  items: listCate.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 580,
                  child: listDrug!.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          controller: controller,
                          itemCount: listDrug!.length + 1,
                          itemBuilder: (context, index) {
                            if (index == listDrug!.length) {
                              return isLoadingMore
                                  ? Center(child: CircularProgressIndicator())
                                  : Container();
                            }
                            return cateChoose == "Thuốc"
                                ? DrugItem(
                                    drugItem: listDrug![index],
                                  )
                                : VacxinItem(vacxinItem: listDrug![index]);
                          },
                        )),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffF8F8F8),
    );
  }
}
