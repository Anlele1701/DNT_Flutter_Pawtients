import 'package:flutter/material.dart';
import 'package:frontend/view/widget/Dich_Vu/service_page.dart';
import 'package:frontend/view/widget/Dich_Vu/service_salon.dart';
import 'package:frontend/view/widget/Products/List_products.dart';
import 'package:frontend/view/widget/Products/List_vaccine.dart';
import 'package:frontend/view/widget/item_list_view.dart';
import 'package:frontend/view/widget/search_bar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'widget/item_card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userNameInput});
  final String userNameInput;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  //trạng thái của nút xem thêm
  bool _isShowMore = false;
  //số lượng items hiển thị ban đầu của list lịch hẹn sắp tới
  int _showedItems = 0;
  //ảnh tạm
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  //dữ liệu cho danh mục
  List<String> categoryTitle = [
    'Khám Bệnh',
    'Tiêm Ngừa',
    'Thuốc',
    'Cắt Tỉa',
  ];
  //lời chào dựa vào thời gian
  String greetingText = "";
  void _updateGreetingText() {
    final now = DateTime.now();
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      setState(() {
        greetingText = 'Chào buổi sáng,';
      });
    } else if (hour >= 12 && hour < 13) {
      setState(() {
        greetingText = 'Chào buổi trưa,';
      });
    } else if (hour >= 13 && hour < 17) {
      setState(() {
        greetingText = 'Chào buổi chiều,';
      });
    } else {
      setState(() {
        greetingText = 'Chào buổi tối,';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateGreetingText();
  }

  @override
  Widget build(BuildContext context) {
    _showedItems = _isShowMore ? 10 : 2;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //TIÊU ĐỀ THAY ĐỔI THEO THỜI GIAN + TÊN NGƯỜI DÙNG
            Text(
              greetingText,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            Text(
              // 'Test',
              '${widget.userNameInput}!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            //CÁC BANNER QUẢNG CÁO
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: imgList
                    .map((item) => Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Image.network(item, fit: BoxFit.cover)),
                        ))
                    .toList(),
              ),
            ),
            //HIỂN THỊ INDEX CỦA BANNER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 25,
                    height: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: (_current == entry.key
                            ? const Color(0XFFF48B29)
                            : const Color(0XFFD9D9D9))),
                  ),
                );
              }).toList(),
            ),
            //THANH TÌM KIẾM
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  shadowColor: WidgetStatePropertyAll(
                      Color(0xffD5D5D5).withOpacity(0.25)),
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 14)),
                  onTap: () {
                    showSearch(context: context, delegate: CustomDelegate());
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  hintText: 'Tìm vaccine, loại dịch vụ khám',
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicePage()));
                    },
                  );
                });
              }),
            ),
            const SizedBox(height: 16),
            //CÁC LỊCH HẸN SẮP TỚI
            const Text('Lịch Hẹn Sắp Tới',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _showedItems,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: index < _showedItems,
                    child: ItemListView(
                      textInput: "Khám Bệnh",
                    ),
                  );
                }),
            TextButton(
              onPressed: () {
                setState(() {
                  _isShowMore = !_isShowMore;
                });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  _isShowMore ? 'Thu Gọn' : 'Hiện Thêm',
                  style: TextStyle(
                      fontSize: 14, color: Color(0xff474747).withOpacity(0.8)),
                ),
                Icon(
                  _isShowMore
                      ? Icons.keyboard_double_arrow_up_rounded
                      : Icons.keyboard_double_arrow_down_rounded,
                  size: 20,
                  color: Color(0xff474747).withOpacity(0.8),
                )
              ]),
            ),

            //DANH MỤC
            const Text('Danh Mục',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: double.infinity,
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: categoryTitle.length,
                itemBuilder: (context, index) {
                  return CateItemView(index: index);
                },
              ),
            ),
            //THUỐC NỔI BẬT
            const SizedBox(height: 16),
            const Text('Vaccine Nổi Bật',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffF48B29))),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ItemCardView();
                },
              ),
            ),
            //VACCINE NỔI BẬT
            const SizedBox(height: 16),
            const Text('Thuốc Nổi Bật',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffF48B29))),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ItemCardView();
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CateItemView extends StatefulWidget {
  int index = 0;
  CateItemView({super.key, required this.index});

  @override
  State<CateItemView> createState() => _CateItemViewState();
}

class _CateItemViewState extends State<CateItemView> {
  final List<String> categoryTitle = [
    'Khám Bệnh',
    'Vaccine',
    'Thuốc',
    'Cắt Tỉa',
  ];

  final List<IconData> categoryIcon = [
    Icons.medical_services_outlined,
    Icons.vaccines_outlined,
    Symbols.pill_rounded,
    Icons.cut_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.index;
    return Container(
        height: 120,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffFEECE2),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: IconButton(
                  color: Color(0xffE2BFB3),
                  onPressed: () {
                    setState(() {
                      if (selectedIndex == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicePage()));
                      } else if (selectedIndex == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VaccinePro()));
                      } else if (selectedIndex == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Products()));
                      } else if (selectedIndex == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalonService()));
                      } else {
                        print('Value not in range (0-3)');
                      }
                    });
                  },
                  icon: Icon(categoryIcon[widget.index]),
                  iconSize: 40),
            ),
            const SizedBox(height: 6),
            Text(
              categoryTitle[widget.index],
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
