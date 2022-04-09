abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialLoadingStates extends SocialStates {}

class SocialSuccessStates extends SocialStates {}

class SocialChangeBottomNavStates extends SocialStates {}

class SocialNewPostStates extends SocialStates {}

class SocialErrorStates extends SocialStates {
  var error;

  SocialErrorStates(this.error);
}
