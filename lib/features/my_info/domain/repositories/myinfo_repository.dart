import '../entities/myinfo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kindblood/core/errors/failure.dart';

abstract class MyInfoRepository {
  void saveMyInfo({required MyInfo myInfo});
  Future<Either<Failure, MyInfo>> getMyInfo();
}
