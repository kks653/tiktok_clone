import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/view_models/user_profile_view_model.dart';

import '../../../constants/sizes.dart';
import '../view_models/user_profile_edit_view_model.dart';

class UserProfileEditingField extends ConsumerStatefulWidget {
  const UserProfileEditingField({
    super.key,
    required this.bioEditingController,
    required this.labelText,
    required this.helperText,
    required this.maxLength,
    required this.maxLines,
  });

  final TextEditingController bioEditingController;
  final String labelText;
  final String helperText;
  final int maxLength;
  final int maxLines;

  @override
  ConsumerState<UserProfileEditingField> createState() =>
      _UserProfileEditingFieldState();
}

class _UserProfileEditingFieldState
    extends ConsumerState<UserProfileEditingField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: TextField(
        onChanged: (text) {
          if (text == ref.watch(userProfileProvider).value!.bio &&
              text == ref.watch(userProfileProvider).value!.link) {
            ref.read(userProfileEditProvider.notifier).onChanged(false);
          } else {
            ref.read(userProfileEditProvider.notifier).onChanged(true);
          }
        },
        onEditingComplete: () {},
        controller: widget.bioEditingController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0),
            borderRadius: BorderRadius.circular(
              Sizes.size12,
            ),
          ),
        ),
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.newline,
      ),
    );
  }
}
