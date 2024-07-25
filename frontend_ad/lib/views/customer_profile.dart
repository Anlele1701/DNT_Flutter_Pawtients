import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend_ad/models/customer.dart';
import 'package:frontend_ad/views/public_views/appbar_drawer.dart';
import 'package:frontend_ad/views/widget/UpperWaveClipper.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key, this.customer});
  final Customer? customer;
  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const AppbarDrawer(
          title: "Thông tin khách hàng",
        ),
        body: Column(
          children: [],
        ));
  }
}
