import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'birthday_screen.dart';
import 'widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty &&
        _password.length > 8 &&
        _password.length < 21;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BirthdayScreen(),
        ));
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Gaps.v40,
            const Text(
              "Password",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v16,
            TextField(
              obscureText: _obscureText,
              onEditingComplete: _onSubmit,
              autocorrect: false,
              autofocus: true,
              controller: _passwordController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                suffix: Row(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                    onTap: _onClearTap,
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
                      color: Colors.grey.shade400,
                      size: Sizes.size20,
                    ),
                  ),
                  Gaps.h16,
                  GestureDetector(
                    onTap: _toggleObscureText,
                    child: FaIcon(
                      _obscureText
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      color: Colors.grey.shade400,
                      size: Sizes.size20,
                    ),
                  ),
                ]),
                hintText: "Make it strong!",
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
            Gaps.v10,
            const Text(
              "Your password must have:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Gaps.v10,
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: Sizes.size20,
                  color:
                      _isPasswordValid() ? Colors.green : Colors.grey.shade400,
                ),
                Gaps.h5,
                const Text("8 to 20 characters"),
              ],
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                disabled: !_isPasswordValid(),
                text: "Next",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
