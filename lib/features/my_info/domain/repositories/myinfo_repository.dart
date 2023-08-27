import '../../../../core/entities/myinfo_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract class MyInfoRepository {
  void saveMyInfo({required MyInfo myInfo});
  Future<Either<Failure, MyInfo>> getMyInfo();
}
