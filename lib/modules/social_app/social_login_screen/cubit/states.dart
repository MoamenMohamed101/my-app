abstract class SocialLoginStates {}

class SocialLoginInitialStates extends SocialLoginStates {}

class SocialLoginLoadingStates extends SocialLoginStates {}

class SocialLoginSucsessStates extends SocialLoginStates {
  var sucsses;
  var uid;
  SocialLoginSucsessStates({this.sucsses,this.uid});
}

class SocialLoginErorrStates extends SocialLoginStates {
  var erorr;
  SocialLoginErorrStates({this.erorr});
}