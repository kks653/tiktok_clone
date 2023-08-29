import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account_detail.dart';

import '../../constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onTapGear() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("경국"),
                actions: [
                  IconButton(
                    onPressed: _onTapGear,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/3642833?v=4",
                      ),
                      child: Text(
                        "경국",
                      ),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@kks653",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size16,
                          color: Colors.blue.shade500,
                        ),
                      ],
                    ),
                    Gaps.v24,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserAccountDetail(
                            title: "Following",
                            number: "97",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserAccountDetail(
                            title: "Followers",
                            number: "10M",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserAccountDetail(
                            title: "Likes",
                            number: "194.3M",
                          ),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size12,
                            horizontal: Sizes.size48,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                4,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gaps.h4,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size7,
                            horizontal: Sizes.size10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Sizes.size4),
                            ),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.youtube,
                          ),
                        ),
                        Gaps.h4,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size7,
                            horizontal: Sizes.size10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Sizes.size4),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v14,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                      ),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+. "
                        "I wonder how it would look",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://www.google.com",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentTabBar(),
              ),
            ];
          },
          body: TabBarView(children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Sizes.size2,
                mainAxisSpacing: Sizes.size2,
                childAspectRatio: 9 / 13,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 9 / 12,
                        child: FadeInImage.assetNetwork(
                          //fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.jpeg",
                          image: "https://source.unsplash.com/random/?$index",
                        ),
                      ),
                      if (index == 0)
                        const Positioned(
                          top: Sizes.size3,
                          left: Sizes.size3,
                          child: Text(
                            "Pinned",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              backgroundColor: Colors.red,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: Sizes.size3,
                        left: Sizes.size3,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                              size: Sizes.size28,
                            ),
                            Text(
                              "61.2M",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.v8,
                ],
              ),
            ),
            const Center(
              child: Text("Page two"),
            ),
          ]),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
