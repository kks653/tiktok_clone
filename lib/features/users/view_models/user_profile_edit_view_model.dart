import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_edit_model.dart';

class UserProfileEditViewModel extends Notifier<UserProfileEditModel> {
  // when user edits the content
  void onChanged(bool value) {
    state = UserProfileEditModel(isEdited: value);
  }

  @override
  UserProfileEditModel build() {
    return UserProfileEditModel(isEdited: false);
  }
}

final userProfileEditProvider =
    NotifierProvider<UserProfileEditViewModel, UserProfileEditModel>(
        () => UserProfileEditViewModel());
