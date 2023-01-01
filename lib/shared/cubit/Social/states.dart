abstract class SocialStates{}

class SocialIntialState extends SocialStates{}

class SocialGetUserDataLoading extends SocialStates{}

class SocialGetUserDataSuccess extends SocialStates{}

class SocialGetUserDataError extends SocialStates{
  final String error;
  SocialGetUserDataError(this.error);
}

class ChangeBottomNav extends SocialStates{}
class ChangeBottomNavToPost extends SocialStates{}

class AddPhotoProfileSuccess extends SocialStates{}
class AddPhotoProfileError extends SocialStates{}

class AddPhotoCoverSuccess extends SocialStates{}
class AddPhotoCoverError extends SocialStates{}

class UploadPhotoProfileSuccess extends SocialStates{}
class UploadPhotoProfileError extends SocialStates{}

class UploadPhotoCoverSuccess extends SocialStates{}
class UploadPhotoCoverError extends SocialStates{}

class AddPhotoPostSuccess extends SocialStates{}
class AddPhotoPostError extends SocialStates{}

class UploadPhotoPostSuccess extends SocialStates{}
class UploadPhotoPostError extends SocialStates{}

class SocialCreatePostLoading extends SocialStates{}

class SocialCreatePostSuccess extends SocialStates{}

class SocialCreatePostError extends SocialStates{
  final String error;
  SocialCreatePostError(this.error);
}

class SocialRemovePostImage extends SocialStates{}

class SocialGetPostLoading extends SocialStates{}

class SocialGetPostSuccess extends SocialStates{}

class SocialGetPostError extends SocialStates{
  final String error;
  SocialGetPostError(this.error);
}

class SocialGetLikesSuccess extends SocialStates{}

class SenNotifySuccess extends SocialStates{}
class SenNotifyError extends SocialStates{}

class SocialGetLikesError extends SocialStates{}

class SocialGetUsersSuccess extends SocialStates{}

class SocialGetUsersError extends SocialStates{}

class SocialChatSuccess extends SocialStates{}

class SocialGetChatSuccess extends SocialStates{}

class SocialGetNotifySuccess extends SocialStates{}

class SocialChatError extends SocialStates{}


