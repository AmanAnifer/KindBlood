import '../../../../core/errors/exceptions.dart';
// import '../models/online_contact_info_model.dart';
import '../../domain/entities/contact_info.dart';
import '../../../../core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../datasources/online_contact_info_datasource.dart';
import '../datasources/online_contact_info_cache_source.dart';
import '../../domain/repositories/online_contact_repository.dart';
import '../../domain/entities/search_info.dart';

class OnlineContactInfoRepositoryImpl implements OnlineContactInfoRepository {
  final OnlineContactInfoDataSource contactInfoDataSource;
  final OnlineContactInfoCacheSource contactInfoCacheSource;
  OnlineContactInfoRepositoryImpl({
    required this.contactInfoDataSource,
    required this.contactInfoCacheSource,
  });

  @override
  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo, required bool fromCache}) async {
    try {
      final List<OnlineContactInfo> resultContacts;
      // if (fromCache) {
      //   resultContacts = await contactInfoCacheSource.getCachedContacts(
      //       onlineSearchInfo: searchInfo);
      // } else {
      resultContacts = await contactInfoDataSource.getSearchResultContacts(
        searchInfo: searchInfo,
      );
      // contactInfoCacheSource.cacheContacts(
      //   onlineSearchInfo: searchInfo,
      //   contactsList: resultContacts
      //       .map(
      //           (e) => OnlineContactInfoModel.fromContactInfo(contactInfo: e))
      //       .toList(),
      // );
      // }
      return Right(resultContacts);
    } on NetworkException {
      return Left(NetworkFailure());
    } on NoCachedContactsException {
      return Left(NoCachedContactsFailure());
    }
  }
}
