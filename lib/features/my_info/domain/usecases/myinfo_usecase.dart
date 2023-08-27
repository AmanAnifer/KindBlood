import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/myinfo_entity.dart';
import '../../../../core/errors/failure.dart';
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
}
