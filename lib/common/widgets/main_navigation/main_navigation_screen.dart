import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/dicover/discover_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../utils.dart';
import '../../../features/inbox/inbox_screen.dart';
import 'widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);
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
    context.go("/${_tabs[index]}");

    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "경국",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size32,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            NavTab(
              text: "Home",
              isSelected: _selectedIndex == 0,
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Discover",
              isSelected: _selectedIndex == 1,
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
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
                inverted: _selectedIndex != 0,
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
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Profile",
              isSelected: _selectedIndex == 4,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              onTap: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ]),
        ),
      ),
    );
  }
}
