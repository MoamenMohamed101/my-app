abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSucsessStates extends SocialRegisterStates {}

class SocialRegisterErorrStates extends SocialRegisterStates {
  var erorr;
  SocialRegisterErorrStates({this.erorr});
}

class SocialCreateUserSucsessStates extends SocialRegisterStates {}

class SocialCreateUserErorrStates extends SocialRegisterStates {
  var erorr;
  SocialCreateUserErorrStates({this.erorr});
}
