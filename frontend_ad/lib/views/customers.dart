import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_ad/models/customer.dart';
import 'package:frontend_ad/views/items/customer_item.dart';
import 'package:frontend_ad/views_models/user_view_model.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Customers> {
  CustomerViewModel customerViewModel = CustomerViewModel();

  Future<List<Customer?>?> fetchData() async {
    return await customerViewModel.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: 750,
              child: FutureBuilder<List<Customer?>?>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Không có khách hàng nào'),
                    );
                  } else {
                    final items = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return CustomerItem(
                          customer: items[index],
                        );
                      },
                      itemCount: items.length,
                    );
                  }
                },
              )),
        ],
      ),
      backgroundColor: const Color(0xffF8F8F8),
    );
  }
}
