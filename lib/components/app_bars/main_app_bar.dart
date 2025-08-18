import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';
import 'package:rgp_landing_take_3/components/common/uniform_button.dart';

class MainAppBar extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const MainAppBar({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 20, 56, 119),
      pinned: true,
      snap: false,
      floating: false,
      toolbarHeight: 70,
      collapsedHeight: 70.0,
      expandedHeight: 70.0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.biggest.height * 0.25;
          return FlexibleSpaceBar(
            title: Text(
              'RGP IT GLOBAL',
              style: TextStyle(
                color: const Color.fromARGB(231, 255, 255, 255),
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 180,
            height: 44,
            child: PrimaryButton(
              text: 'Contact Us',
              onPressed: () {
                scrollHelper.scrollToSection(scrollController, 2); // Contact Us
              },
              isMobile: false,
            ),
          ),
        ),
      ],
    );
  }
}
