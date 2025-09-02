import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';

class TopAppBar extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollControllerHelper scrollHelper;

  const TopAppBar({
    super.key,
    required this.scrollController,
    required this.scrollHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 32.0,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const FlexibleSpaceBar(),
          Positioned(
            top: 0.12,
            right: 24.50,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Ensure page lengths are calculated before scrolling
                    if (scrollHelper.pl1 == 0) {
                      // Recalculate page lengths if not done
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollHelper.calculatePageLengths(context);
                        scrollHelper.scrollToSection(scrollController, 1);
                      });
                    } else {
                      // Use existing calculated lengths
                      scrollHelper.scrollToSection(scrollController, 1);
                    }
                  },
                  child: const Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // Phone button
                  },
                  child: const Text(
                    '+1 234 456 890',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      pinned: true,
    );
  }
}
