import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/bill.dart';
import 'package:frontend_ad/views/items/purchase_item.dart';
import 'package:frontend_ad/views_models/bill_view_model.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Bills> {
  final ScrollController scrollController = ScrollController();
  BillViewModel billViewModel = BillViewModel();
  Future<List<Bill?>?> getListBill() async {
    return await billViewModel.getBillList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: const Text(
                    "Hóa đơn",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                ),
                // Row(
                //   children: [
                //     const SizedBox(
                //       width: 200,
                //       child: TextField(
                //         decoration: InputDecoration(
                //             hintText: "Tìm kiếm", border: InputBorder.none),
                //         // controller: searchController,
                //       ),
                //     ),
                //     IconButton(
                //       icon: const Icon(Icons.search),
                //       onPressed: () {
                //         setState(() {});
                //       },
                //     )
                //   ],
                // ),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 670,
                child: FutureBuilder<List<Bill?>?>(
                    future: getListBill(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Không có hóa đơn nào'),
                        );
                      } else {
                        final items = snapshot.data;
                        return ListView.builder(
                          itemCount: items?.length,
                          itemBuilder: (context, index) {
                            return PurchaseItem(item: items?[index]);
                          },
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
