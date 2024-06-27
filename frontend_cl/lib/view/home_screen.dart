import 'package:flutter/material.dart';
import 'package:frontend/view/widget/BottomNavBar.dart';
import 'package:frontend/view/widget/app_bar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    'Triệt Sản',
  ];

  @override
  Widget build(BuildContext context) {
    _showedItems = _isShowMore ? 10 : 2;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55), child: MyAppBar(title: '')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //TIÊU ĐỀ THAY ĐỔI THEO THỜI GIAN + TÊN NGƯỜI DÙNG
            const Text(
              'Chào buổi sáng,',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            const Text(
              'Duy Ân!',
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
                    controller.openView();
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
                      setState(() {
                        controller.closeView(item);
                      });
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ItemCardView extends StatelessWidget {
  const ItemCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 160,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xffD5D5D5).withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.network(
                'https://hanvet.com.vn/uploads/S%E1%BA%A3n%20ph%E1%BA%A9m/v%E1%BA%AFc%20xin/Ch%C3%B3%20m%C3%A8o/Rabiva.png',
                height: 120,
              ),
            ),
            Text(
              'Vaccine ngừa dại Rabiva',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '300.000đ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
    'Tiêm Ngừa',
    'Thuốc',
    'Cắt Tỉa',
    'Triệt Sản',
  ];

  final List<IconData> categoryIcon = [
    Icons.medical_services_outlined,
    Icons.vaccines_outlined,
    Symbols.pill_rounded,
    Icons.health_and_safety_outlined,
    Symbols.surgical,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                  onPressed: () {},
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

class ItemListView extends StatefulWidget {
  const ItemListView({
    super.key,
    required this.textInput,
  });
  final String textInput;

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 145, 229, 148),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 56, 56, 56).withOpacity(0.25),
              offset: const Offset(1, 2),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xffFFC368)),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                "https://randomuser.me/api/portraits/med/men/8.jpg",
                width: 30,
                height: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.widget.textInput,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '9:00 - 20/7/2024',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Gâu Gâu - Bác sĩ Ngọc',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 30,
              opticalSize: 30,
              color: Color(0xff555555),
            ),
          )
        ],
      ),
    );
  }
}
