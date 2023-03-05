abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginGoogleSinginSuccesStates extends LoginStates {
  final String? uid;

  LoginGoogleSinginSuccesStates(this.uid);
}

class LoginGoogleSinginLoadingStates extends LoginStates {}

class LoginGoogleSinginErrorStates extends LoginStates {
  final String error;

  LoginGoogleSinginErrorStates(this.error);
}

class LoginSuccessState extends LoginStates {
  final String? uid;

  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginFacebookSuccessState extends LoginStates {
  final String? uid;

  LoginFacebookSuccessState(this.uid);
}

class LoginFacebookLoadingState extends LoginStates {}

class LoginFacebookErrorState extends LoginStates {
  final String? error;

  LoginFacebookErrorState(this.error);
}

class GetUserDataSuccess extends LoginStates {
  final String? uid;

  GetUserDataSuccess(this.uid);
}

class GetUserDataLoading extends LoginStates {}

class GetUserDataerror extends LoginStates {
  final String? error;

  GetUserDataerror(this.error);
}

class VerifyNumberSuccessState extends LoginStates {}

class VerifyNumberLoadingState extends LoginStates {}

class VerifyNumberErrorState extends LoginStates {
  final String? error;

  VerifyNumberErrorState(this.error);
}

class VerifyOtpSuccessState extends LoginStates {}

class VerifyOtpLoadingState extends LoginStates {}

class VerifyOtpErrorState extends LoginStates {}

class AddPhoneSuccessState extends LoginStates {
  final String? uid;

  AddPhoneSuccessState(this.uid);
}

class AddPhoneErrorState extends LoginStates {}

class AddPhoneloadingState extends LoginStates {}

class ChangeCountryState extends LoginStates {}
