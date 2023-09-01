import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/settings/views/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/user_profile_edit_view_model.dart';
import 'package:tiktok_clone/features/users/view_models/user_profile_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_edit_sheet.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account_detail.dart';

import '../../../constants/sizes.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onTapGear() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onTapEditBio(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const UserProfileEditSheet(),
      useSafeArea: true,
    );

    //_onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProfileProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => SafeArea(
            child: DefaultTabController(
              initialIndex: widget.tab == "likes" ? 1 : 0,
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: Text(data.name),
                      actions: [
                        IconButton(
                          onPressed: () => _onTapEditBio(context),
                          icon: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            size: Sizes.size20,
                          ),
                        ),
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
                          Avatar(
                            name: data.name,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          Gaps.v20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "@${data.name}",
                                style: const TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size32,
                            ),
                            child: Text(
                              ref.read(userProfileProvider).value!.bio,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Gaps.v14,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.link,
                                size: Sizes.size12,
                              ),
                              Gaps.h4,
                              Text(
                                ref.read(userProfileProvider).value!.link,
                                style: const TextStyle(
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: 20,
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                image:
                                    "https://source.unsplash.com/random/?$index",
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
          ),
        );
  }
}
