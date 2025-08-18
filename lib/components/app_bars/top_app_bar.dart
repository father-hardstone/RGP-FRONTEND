import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/utils/scroll_controller.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

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
                    // About Us button - will be handled by parent
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
