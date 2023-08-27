import 'package:fpdart/fpdart.dart';

import 'package:kindblood/core/errors/exceptions.dart';
import 'package:kindblood/core/errors/failure.dart';
import '../model/myinfo_model.dart';

import '../../domain/entities/myinfo.dart';

import '../datasource/myinfo_db_datasource.dart';
import '../../domain/repositories/myinfo_repository.dart';

class MyInfoRepositoryImpl implements MyInfoRepository {
  final MyInfoDBDatasource myInfoDBDatasource;
  MyInfoRepositoryImpl({required this.myInfoDBDatasource});

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
}
