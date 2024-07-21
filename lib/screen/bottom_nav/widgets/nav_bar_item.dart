import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant/constant.dart';
import '../bottom_nav_bar.dart';

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