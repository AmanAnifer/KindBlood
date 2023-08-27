import 'package:hive_flutter/hive_flutter.dart';
import '../model/myinfo_model.dart';
import 'package:kindblood/core/errors/exceptions.dart';

abstract class MyInfoDBDatasource {
  void saveMyInfo({required MyInfoModel myInfo});
  Future<MyInfoModel> getMyInfo();
}

class HiveMyInfoDBDatasource implements MyInfoDBDatasource {
  static const String myInfoDBKey = "myInfo";
  final Box box;
  HiveMyInfoDBDatasource({required this.box});

  @override
  Future<MyInfoModel> getMyInfo() async {
    var myInfo = box.get(myInfoDBKey);
    if (myInfo == null) {
      throw NoExistingMyInfoException();
    } else {
      var castedMyInfo = Map<String, dynamic>.from(myInfo);
      return MyInfoModel.fromJson(json: castedMyInfo);
    }
  }

  @override
  void saveMyInfo({required MyInfoModel myInfo}) {
    box.put(myInfoDBKey, myInfo.toJson());
  }
}
