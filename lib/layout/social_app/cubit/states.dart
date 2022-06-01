abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialLoadingStates extends SocialStates {}

class SocialSuccessStates extends SocialStates {}

class SocialChangeBottomNavStates extends SocialStates {}

class SocialNewPostStates extends SocialStates {}

class SocialProfileImagePickedSuccessStates extends SocialStates {}

class SocialProfileImagePickedErrorStates extends SocialStates {}

class SocialCoverImagePickedSuccessStates extends SocialStates {}

class SocialCoverImagePickedErrorStates extends SocialStates {}

class SocialErrorStates extends SocialStates {
  var error;

  SocialErrorStates(this.error);
}

class SocialUploadProfileImageSuccessStates extends SocialStates {}

class SocialUploadProfileImageErrorStates extends SocialStates {}

class SocialUploadCoverImageSuccessStates extends SocialStates {}

class SocialUploadCoverImageErrorStates extends SocialStates {}

class SocialUserUpdateErrorStates extends SocialStates {}

class SocialUserUpdateLoadingStates extends SocialStates {}
