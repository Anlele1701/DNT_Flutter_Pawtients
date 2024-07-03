import 'package:flutter/material.dart';
import 'package:frontend/view/widget/item_list_view.dart';

void showAnimatedDialog(BuildContext context) {
  showGeneralDialog(
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 650,
              child: Column(
                children: [
                  Text(
                    "Lịch sử Đặt lịch",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    // Wrap the scrollable area in Expanded
                    child: SingleChildScrollView(
                      // Use SingleChildScrollView for scrolling
                      child: Column(
                        // Inner Column for list items
                        children: [
                          for (var i = 0; i < label.length; i++)
                            ItemListView(textInput: label[i]),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.cancel_outlined))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

List<String> label = [
  "Lê thoại bảo ngọc",
  "Trương Quang Huy",
  "Nguyễn Tiến Thành",
  "Lê Thành Duy Ân",
  "Trương Quang Béo",
  "Tôn Ngộ Không",
  "Người dùng ẩn danh"
];
