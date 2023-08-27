import '../models/online_contact_info_model.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:http/http.dart';
import '../../domain/entities/search_info.dart';

typedef OnlineContactResponse = Future<List<OnlineContactInfoModel>>;

abstract class OnlineContactInfoDataSource {
  OnlineContactResponse getSearchResultContacts(
      {required OnlineSearchInfo searchInfo});
}

class HTTPOnlineContactInfoDataSourceImpl
    implements OnlineContactInfoDataSource {
  final Client httpClient;
  HTTPOnlineContactInfoDataSourceImpl({required this.httpClient});
  @override
  OnlineContactResponse getSearchResultContacts({
    required OnlineSearchInfo searchInfo,
  }) async {
    // TODO: actual code bruh
    throw NetworkException();
  }
}
