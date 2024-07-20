import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/constant.dart';

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

class NavBarItem extends StatefulWidget {
  final NavBarData data;
  final bool isSelected;
  final Size size;
  const NavBarItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.size,
  });

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _sizeAnimation = Tween<double>(
      begin: 0,
      end: widget.isSelected ? 44.r : 24.r,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(
            begin:
                widget.isSelected ? Colors.white : Colors.black.withOpacity(.1),
            end: widget.isSelected ? AppColors.primaryColor : AppColors.white)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * .13,
      height: widget.size.height * .08,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: _sizeAnimation.value,
              width: _sizeAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _colorAnimation.value,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              widget.data.iconPath,
              colorFilter: ColorFilter.mode(
                  widget.isSelected ? Colors.black : Colors.white,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NavBarData {
  final String iconPath;

  NavBarData({required this.iconPath});
}
