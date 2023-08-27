part of 'myinfo_upload_cubit.dart';

abstract class MyInfoUploadState {}

class MyInfoUploadInitial implements MyInfoUploadState {}

class MyInfoUploadable implements MyInfoUploadState {}

class MyInfoUploading implements MyInfoUploadState {}

class MyInfoUploadComplete implements MyInfoUploadState {}

class MyInfoUploadError implements MyInfoUploadState {}
