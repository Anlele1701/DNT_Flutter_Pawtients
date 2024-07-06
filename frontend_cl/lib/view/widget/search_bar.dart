import 'package:flutter/material.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/view/widget/item_card_view.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => MySearchBarState();
}

class MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          title: "",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 10),
                ),
                hintText: "Vaccine, thuốc, ...",
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.cancel,
                  size: 30,
                ),
              ),
              onTap: () {
                showSearch(context: context, delegate: CustomDelegate());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate {
  List<String> test = ["Thuốc 1", "Thuốc 2", "Thuốc 3", "Thuốc 4"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> testres = [];
    for (var item in test) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
      ;
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return Container(
          margin: EdgeInsets.all(8),
          height: 20,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.red),
          child: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> testres = [];
    for (var item in test) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
      ;
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return Container(
          margin: EdgeInsets.all(8),
          height: 70,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), border: Border.all()),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result),
                    Text("300,000đ"),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.red),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
