import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../generated/l10n.dart';
import '../../authentication/widgets/form_button.dart';

class UserProfileEditSheet extends ConsumerStatefulWidget {
  const UserProfileEditSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditSheet> {
  final TextEditingController _bioEditingController =
      TextEditingController(text: "Bio");
  final TextEditingController _linkEditingController =
      TextEditingController(text: "Link");

  void _onSave() {}

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(S.of(context).editProfileTitle),
          actions: const [
            CloseButton(
              color: Colors.black,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size10,
            vertical: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditingProfileField(
                textEditingController: _bioEditingController,
                labelText: S.of(context).bio,
                helperText: S.of(context).editBio,
              ),
              Gaps.v32,
              EditingProfileField(
                textEditingController: _linkEditingController,
                labelText: S.of(context).link,
                helperText: S.of(context).editLink,
              ),
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: _onSave,
          child: const Padding(
            padding: EdgeInsets.all(
              Sizes.size40,
            ),
            child: FormButton(
              disabled: true,
              text: "save",
            ),
          ),
        ),
      ),
    );
  }
}

class EditingProfileField extends StatelessWidget {
  const EditingProfileField({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.helperText,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Sizes.size12,
          ),
        ),
      ),
      // expands: true,
      // minLines: null,
      // maxLines: null,
      // textInputAction: TextInputAction.newline,
    );
  }
}
