import 'package:fpdart/fpdart.dart';
import 'package:kindblood/core/errors/success.dart';
import 'package:kindblood/features/my_info/data/datasource/myinfo_upload_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../model/myinfo_model.dart';
import 'package:kindblood_common/core_entities.dart';

import '../datasource/myinfo_db_datasource.dart';
import '../../domain/repositories/myinfo_repository.dart';

class MyInfoRepositoryImpl implements MyInfoRepository {
  final MyInfoDBDatasource myInfoDBDatasource;
  final MyInfoUploadDatasource myInfoUploadDatasource;
  MyInfoRepositoryImpl({
    required this.myInfoDBDatasource,
    required this.myInfoUploadDatasource,
  });

  @override
  Future<Either<Failure, MyInfo>> getMyInfo() async {
    try {
      var myInfo = await myInfoDBDatasource.getMyInfo();
      return Either.right(myInfo);
    } on NoExistingMyInfoException {
      return Either.left(NoExistingMyInfoFailure());
    }
  }

  @override
  void saveMyInfo({required MyInfo myInfo}) {
    myInfoDBDatasource.saveMyInfo(
      myInfo: MyInfoModel.fromMyInfo(myInfo: myInfo),
    );
  }

  @override
  Future<Either<Failure, Success>> uploadMyInfo(
      {required MyInfo myInfo}) async {
    try {
      var result = await myInfoUploadDatasource.uploadMyInfo(myInfo: myInfo);
      return Either.right(result);
    } on NetworkException {
      return Either.left(NetworkFailure());
    }
  }
}
