import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

import '../../../constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatID;

  const ChatDetailScreen({super.key, required this.chatID});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _showSuggestedEmoji = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _showSuggestedEmoji = !_focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(children: [
            const CircleAvatar(
              foregroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/3642833?v=4",
              ),
              radius: Sizes.size20,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                constraints: const BoxConstraints.expand(
                    width: Sizes.size12, height: Sizes.size12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: Sizes.size2,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ]),
          title: Text(
            "경국 (${widget.chatID})",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text(
            "Active now",
            style: TextStyle(
              fontSize: Sizes.size12,
            ),
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: const [
            FaIcon(
              FontAwesomeIcons.flag,
              color: Colors.black,
              size: Sizes.size24,
            ),
            Gaps.h32,
            FaIcon(
              FontAwesomeIcons.ellipsis,
              color: Colors.black,
              size: Sizes.size24,
            ),
          ]),
        ), //bottom: BottomAppBar(child: ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(children: [
          ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.only(
              top: Sizes.size10,
              bottom: Sizes.size96 + Sizes.size20,
              right: Sizes.size16,
              left: Sizes.size16,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size20),
                        topRight: const Radius.circular(Sizes.size20),
                        bottomLeft: Radius.circular(
                          isMine ? Sizes.size20 : Sizes.size5,
                        ),
                        bottomRight: Radius.circular(
                          !isMine ? Sizes.size20 : Sizes.size5,
                        ),
                      ),
                    ),
                    child: const Text(
                      "This is a message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 50,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              elevation: 0,
              padding: const EdgeInsets.only(
                left: Sizes.size14,
                right: Sizes.size14,
                top: Sizes.size10,
              ),
              //color: Colors.grey.shade50,
              child: Column(
                children: [
                  Visibility(
                    visible: _showSuggestedEmoji,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            Sizes.size7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(
                              Sizes.size24,
                            ),
                          ),
                          child: Row(
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          padding: const EdgeInsets.all(
                            Sizes.size7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(
                              Sizes.size24,
                            ),
                          ),
                          child: Row(
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          padding: const EdgeInsets.all(
                            Sizes.size7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(
                              Sizes.size24,
                            ),
                          ),
                          child: Row(
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          //controller: _textEditingController,
                          textInputAction: TextInputAction.send,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Send a message...",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Sizes.size28,
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {}, // TODO
                              icon: const FaIcon(
                                FontAwesomeIcons.faceLaugh,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.h10,
                      Container(
                        child: const FaIcon(FontAwesomeIcons.paperPlane),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
