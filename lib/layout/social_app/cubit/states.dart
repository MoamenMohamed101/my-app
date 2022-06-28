abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialLoadingStates extends SocialStates {}

class SocialSuccessStates extends SocialStates {}

class SocialGetAllUsersLoadingStates extends SocialStates {}

class SocialGetAllUsersSuccessStates extends SocialStates {}

class SocialGetAllUsersErrorStates extends SocialStates {}

class SocialGetPostsLoadingStates extends SocialStates {}

class SocialGetPostsSuccessStates extends SocialStates {}

class SocialLikePostsErrorStates extends SocialStates {}

class SocialLikePostsSuccessStates extends SocialStates {}

class SocialGetPostsErrorStates extends SocialStates {}

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

// create post
class SocialCreatePostSuccessStates extends SocialStates {}

class SocialCreatePostLoadingStates extends SocialStates {}

class SocialCreatePostErrorStates extends SocialStates {}

class SocialPostImagePickedSuccessStates extends SocialStates {}

class SocialPostImagePickedErrorStates extends SocialStates {}

class SocialPostImageRemovedStates extends SocialStates {}
