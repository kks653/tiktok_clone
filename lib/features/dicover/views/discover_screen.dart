import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/utils.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../common/break_points.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  bool _isWriting = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
  }

  void _onTabIndexChanged() {
    FocusScope.of(context).unfocus();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isWriting = value.isNotEmpty;
    });
  }

  void _onSearchSubmitted(String value) {
    // TODO
  }

  void _onTapClear() {
    _textEditingController.clear();

    setState(() {
      _isWriting = _textEditingController.value.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.filter,
              ),
            ),
          ],
          centerTitle: true,
          elevation: 1,
          // title: TextField(
          //   //maxLines: 1,
          //   //maxLength: 20,
          //   controller: _textEditingController,
          //   onChanged: _onSearchChanged,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Colors.grey.shade200,
          //     border: const OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //     ),
          //     prefixIcon: const Padding(
          //       padding: EdgeInsets.symmetric(
          //         vertical: Sizes.size14,
          //         horizontal: Sizes.size14,
          //       ),
          //       child: FaIcon(
          //         FontAwesomeIcons.magnifyingGlass,
          //         color: Colors.black,
          //         size: Sizes.size16 + Sizes.size2,
          //       ),
          //     ),
          //     hintText: "Search",
          //     suffixIcon: _isWriting == true
          //         ? Padding(
          //             padding: const EdgeInsets.symmetric(
          //               vertical: Sizes.size14,
          //             ),
          //             child: IconButton(
          //               onPressed: _onTapClear,
          //               icon: FaIcon(
          //                 FontAwesomeIcons.solidCircleXmark,
          //                 color: Colors.grey.shade500,
          //               ),
          //             ),
          //           )
          //         : null,
          //   ),
          // ),
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              placeholder: "검색",
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
          bottom: TabBar(
              onTap: (value) => _onTabIndexChanged(),
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ]),
        ),
        body: GestureDetector(
          onVerticalDragCancel: _stopWriting,
          onTap: _stopWriting,
          child: TabBarView(children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 16,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 12,
                      child: FadeInImage.assetNetwork(
                        //fit: BoxFit.cover,
                        placeholder: "assets/images/placeholder.jpeg",
                        image: "https://source.unsplash.com/random/?$index",
                      ),
                    ),
                  ),
                  Gaps.v8,
                  const Text(
                    "This is a very long caption for my tiktok that I am uploading just now currently",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  Gaps.v5,
                  DefaultTextStyle(
                    style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/3642833?v=4",
                          ),
                        ),
                        Gaps.h4,
                        const Expanded(
                          child: Text(
                            "My avatar is going to be very long",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h2,
                        const Text(
                          "2.5M",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size32,
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
