import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UserProfileViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;
  // String _bio = "undefined";
  // String _username = "undefined";

  @override
  FutureOr<UserProfileModel> build() async {
    // await Future.delayed(
    //   const Duration(seconds: 10),
    // );

    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJosn(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) throw Exception("Account not created");

    final form = ref.watch(signUpForm);

    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      email: credential.user!.email ?? form["email"],
      bio: "undefined",
      link: "undefined",
      birthday: form["birthday"],
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? form["username"],
    );

    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;

    state = AsyncValue.data(state.value!.copywith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  // void setBirthDate(Stri~ng birthDate) {
  //   _bio = birthDate;
  // }

  // void setUsername(String username) {
  //   _username = username;
  // }
}

final usersProvider =
    AsyncNotifierProvider<UserProfileViewModel, UserProfileModel>(
  () => UserProfileViewModel(),
);