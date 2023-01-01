abstract class LoginStates{}

class LoginIntialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}

class UpdateTokenSuccessState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}

class ChangeIconPass extends LoginStates{}