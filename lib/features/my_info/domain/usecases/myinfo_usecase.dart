import '../entities/myinfo.dart';
import '../repositories/myinfo_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kindblood/core/errors/failure.dart';

class MyInfoUsecase {
  final MyInfoRepository myInfoRepository;

  MyInfoUsecase({required this.myInfoRepository});

  void saveMyInfo({required MyInfo myInfo}) {
    myInfoRepository.saveMyInfo(myInfo: myInfo);
  }

  Future<Either<Failure, MyInfo>> getMyInfo() {
    return myInfoRepository.getMyInfo();
  }
}
