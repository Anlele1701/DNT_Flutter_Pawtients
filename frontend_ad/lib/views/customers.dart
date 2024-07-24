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
  CustomerViewModel customerViewModel= CustomerViewModel();

  Future<List<Customer?>?> fetchData()async{
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
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasError){
                  return Center(child: Text('${snapshot.error}'),);
                }
                else if(!snapshot.hasData||snapshot.data!.isEmpty){
                  return Center(child: Text('Không có khách hàng nào'),);
                }
                else{
                  final items=snapshot.data!;
                  return ListView.builder(itemBuilder: (context, index){
                    print(items.length);
                    return CustomerItem(customer: items[index],);
                  }, itemCount: items.length,);
                }
              },
            )
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Color(0xffF48B29), shape: BoxShape.circle),
                  child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.add, size: 30,),
                  color: Colors.white,
                        ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xffF8F8F8),
    );
  }
}