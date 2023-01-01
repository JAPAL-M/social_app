abstract class RegisterStates{}

class RegisterIntialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}

class UserCreateLoadingState extends RegisterStates{}

class UserCreateSuccessState extends RegisterStates{
  final String uId;
  UserCreateSuccessState(this.uId);
}

class UserCreateErrorState extends RegisterStates{
  final String error;

  UserCreateErrorState(this.error);
}

class ChangeIconPassRe extends RegisterStates {}