import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/users/view_models/user_profile_edit_view_model.dart';
import 'package:tiktok_clone/features/users/view_models/user_profile_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_editing_field.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../generated/l10n.dart';

class UserProfileEditSheet extends ConsumerStatefulWidget {
  const UserProfileEditSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditSheet> {
  late final TextEditingController _bioEditingController;
  late final TextEditingController _linkEditingController;

  bool isEdited = false;

  Future<void> _onTapSave() async {
    if (!ref.watch(userProfileEditProvider).isEdited) return;

    await ref.read(userProfileProvider.notifier).onBioUpdate(
        _bioEditingController.value.text,
        _linkEditingController.value.text,
        context);
  }

  @override
  void initState() {
    _bioEditingController =
        TextEditingController(text: ref.read(userProfileProvider).value!.bio);
    _linkEditingController =
        TextEditingController(text: ref.read(userProfileProvider).value!.link);

    super.initState();
  }

  @override
  void dispose() {
    _bioEditingController.dispose();
    _linkEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size12,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(S.of(context).editProfileTitle),
          actions: [
            CloseButton(
              onPressed: () {
                ref.read(userProfileEditProvider.notifier).onChanged(false);
                context.pop();
              },
              color: Colors.black,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
                vertical: Sizes.size20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserProfileEditingField(
                    bioEditingController: _bioEditingController,
                    labelText: S.of(context).bio,
                    helperText: S.of(context).editBio,
                    maxLength: 100,
                    maxLines: 3,
                  ),
                  Gaps.v32,
                  UserProfileEditingField(
                    bioEditingController: _linkEditingController,
                    labelText: S.of(context).link,
                    helperText: S.of(context).editLink,
                    maxLength: 50,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size24,
            horizontal: Sizes.size24,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: !ref.watch(userProfileEditProvider).isEdited ? 0 : 1,
            child: CupertinoButton(
              onPressed: _onTapSave,
              color: Theme.of(context).primaryColor,
              child: const Text("Save"),
            ),
          ),
        ),
      ),
    );
  }
}
