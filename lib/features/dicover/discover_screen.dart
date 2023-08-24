import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Discover",
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Top",
            ),
            Tab(
              text: "Users",
            ),
          ]),
        ),
      ),
    );
  }
}
