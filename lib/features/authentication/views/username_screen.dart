import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import 'email_screen.dart';
import '../widgets/form_button.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "username": _username};

    //ref.read(usersProvider.notifier).setUsername(_username);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(username: _username),
      ),
    );
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
            "Create username",
            style: TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.v8,
          const Text(
            "You can always change this later.",
            style: TextStyle(
              fontSize: Sizes.size16,
              color: Colors.black54,
            ),
          ),
          Gaps.v16,
          TextField(
            onEditingComplete: _onNextTap,
            autofocus: true,
            controller: _usernameController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: "Username",
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
              disabled: _username.isEmpty,
              text: "Next",
            ),
          ),
        ]),
      ),
    );
  }
}
