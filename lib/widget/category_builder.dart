import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';
import '../widget/product_card.dart';

import '../models/product_model.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder(
      {super.key, required this.title, required this.products});
  final String title;
  final List<Product> products;

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  var _currentPage = 0;

  int get _page => (widget.products.length / 2).round();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.camelCase(),
            style: GoogleFonts.montserrat(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: PageView.builder(
              itemCount: _page,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (_, i) {
                final i1 = i + (i + 0);
                final i2 = i + (i + 1);

                final lastIndexReached = i2 >= widget.products.length;

                return Row(
                  children: [
                    Expanded(
                      child: ProductCard(product: widget.products[i1]),
                    ),
                    const SizedBox(width: 13.0),
                    Expanded(
                      child: lastIndexReached
                          ? const SizedBox()
                          : ProductCard(product: widget.products[i2]),
                    ),
                  ],
                );
              },
            ),
          ),
           SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _page; i++) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 12.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primaryColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: _currentPage == i
                        ? null
                        : Border.all(
                            color: const Color(0xFFBBBBBB),
                          ),
                  ),
                ),
                const SizedBox(width: 13.0),
              ],
            ],
          )
        ],
      ),
    );
  }
}
