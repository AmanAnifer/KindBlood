import 'package:kindblood/core/errors/success.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class MyInfoRepository {
  void saveMyInfo({required MyInfo myInfo});
  Future<Either<Failure, MyInfo>> getMyInfo();
  Future<Either<Failure, Success>> uploadMyInfo({required MyInfo myInfo});
}
