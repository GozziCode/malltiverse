import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';
import 'widgets/nav_bar_item.dart';

typedef OnItemChanged = void Function(int newPosition);

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final OnItemChanged onItemChanged;
  final List<NavBarData> navBarItems;
  const BottomNavBar({
    super.key,
    required this.onItemChanged,
    required this.navBarItems,
    required this.currentIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  @override
  void initState() {
    selectedIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 34.w, vertical: 5),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 24),
      height: size.height * 0.36 / 5,
      decoration: BoxDecoration(
          color: AppColors.black,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: const Offset(5, 10)),
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: const Offset(-5, -10))
          ],
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.navBarItems.map((item) {
          final index = widget.navBarItems.indexOf(item);
          return GestureDetector(
            onTap: () {
              widget.onItemChanged(index); // Notify parent about the change
            },
            child: NavBarItem(
              key: UniqueKey(),
              size: size,
              data: item,
              isSelected: index == widget.currentIndex,
            ),
          );
        }).toList(),
      ),
    );
  }
}


class NavBarData {
  final String iconPath;

  NavBarData({required this.iconPath});
}
