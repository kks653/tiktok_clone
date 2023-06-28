import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  bool _onTapDown = false;
  Color buttonColor = Colors.white;

  final screens = [
    const Center(
      child: Text(
        "Home",
        style: TextStyle(
          fontSize: Sizes.size80,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Discover",
        style: TextStyle(
          fontSize: Sizes.size80,
        ),
      ),
    ),
    Container(),
    const Center(
      child: Text(
        "Inbox",
        style: TextStyle(
          fontSize: Sizes.size80,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Profile",
        style: TextStyle(
          fontSize: Sizes.size80,
        ),
      ),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Record video",
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            NavTab(
              text: "Home",
              isSelected: _selectedIndex == 0,
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              onTap: () => _onTap(0),
            ),
            NavTab(
              text: "Discover",
              isSelected: _selectedIndex == 1,
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              onTap: () => _onTap(1),
            ),
            Gaps.h24,
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _onTapDown = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _onTapDown = true;
                });
              },
              onTap: _onPostVideoButtonTap,
              child: PostVideoButton(
                onTapDown: _onTapDown,
              ),
            ),
            Gaps.h24,
            NavTab(
              text: "Inbox",
              isSelected: _selectedIndex == 3,
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              onTap: () => _onTap(3),
            ),
            NavTab(
              text: "Profile",
              isSelected: _selectedIndex == 4,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              onTap: () => _onTap(4),
            ),
          ]),
        ),
      ),
    );
  }
}