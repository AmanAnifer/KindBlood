import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../repositories/myinfo_repository.dart';

class MyInfoUsecase {
  final MyInfoRepository myInfoRepository;

  MyInfoUsecase({required this.myInfoRepository});

  void saveMyInfo({required MyInfo myInfo}) {
    myInfoRepository.saveMyInfo(myInfo: myInfo);
  }

  Future<Either<Failure, MyInfo>> getMyInfo() {
    return myInfoRepository.getMyInfo();
  }

  Future<Either<Failure, Success>> uploadMyInfo(
      {required MyInfo myInfo}) async {
    return myInfoRepository.uploadMyInfo(myInfo: myInfo);
  }
}
