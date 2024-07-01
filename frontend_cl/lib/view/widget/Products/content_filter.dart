import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

List<String> tags = [''];

List<String> options = ['Kháng sinh', 'Tiêu hóa', 'Dinh dưỡng', 'Sốt', 'Khác'];

bool selected = false;
bool showChips = false;
bool isIconRotated = false;


int tag = 1;
List<String> options2 = ['Bắt buộc', 'Hỗ trợ'];
//Custom UI cho chíp
class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool selected) onSelect;
  const CustomChip({
    Key? key,
    required this.label,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 5),
        child: FilterChip(
          label: Text(
            label,
            style: TextStyle(
                color: selected ? Color(0xFFFFFFFF) : Color(0xFF534F4F)),
          ),
          selected: selected,
          onSelected: onSelect,
          selectedColor: Colors.amber[800],
          backgroundColor: Colors.white,
          checkmarkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
            side: BorderSide(
                color: selected ? Color(0xFFFFFFFF) : Color(0xFF534F4F),
                width: 0.5 // Border color
                ),
          ),
        ));
  }
}
Widget GradientColor() {
  return Positioned.fill(
      child: Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xFFF1B237), Color(0xFFFB7E09)],
      stops: [0.12, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )),
  ));
}

//Show ra các chips
class MyChips extends StatefulWidget {
  const MyChips({super.key});

  @override
  State<MyChips> createState() => _MyChipsState();
}

class _MyChipsState extends State<MyChips> {
  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.multiple(
      value: tags,
      // mốt viết hàm ra filter tại đây
      onChanged: (val) => setState(() {
        tags = val;
        for (int i = 0; i < tags.length; i++) {
          print(tags[i]);
        }
      }),
      choiceItems: C2Choice.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceBuilder: (item, i) {
        return CustomChip(
          label: item.label,
          selected: item.selected,
          onSelect: item.select!,
        );
      },
    );
  }
}