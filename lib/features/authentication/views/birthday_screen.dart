import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime(DateTime.now().year - 12);
  DateTime minAge = DateTime(12);

  String _birthday = "undefined";

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "birthday": _birthday};

    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    _birthday = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: _birthday);

    //ref.read(usersProvider.notifier).setBirthDate(textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Gaps.v40,
          const Text(
            "When's your birthday?",
            style: TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.v8,
          const Text(
            "Your birthday won't be shown publicly",
            style: TextStyle(
              fontSize: Sizes.size16,
              color: Colors.black54,
            ),
          ),
          Gaps.v16,
          TextField(
            enabled: false,
            onEditingComplete: _onNextTap,
            autofocus: true,
            controller: _birthdayController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          Gaps.v16,
          GestureDetector(
            onTap: _onNextTap,
            child: FormButton(
              disabled: ref.watch(signUpProvider).isLoading,
              text: "Next",
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      )),
    );
  }
}
