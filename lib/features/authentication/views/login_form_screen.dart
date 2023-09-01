import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/login_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write your email.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData["email"] = newValue;
                      }
                    },
                  ),
                  Gaps.h16,
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Password"),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData["password"] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  GestureDetector(
                    onTap: _onSubmitTap,
                    child: FormButton(
                      disabled: ref.watch(loginProvider).isLoading,
                      text: "Log in",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
