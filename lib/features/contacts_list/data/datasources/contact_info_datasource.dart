import 'package:permission_handler/permission_handler.dart';
import '../models/offline_contact_info_model.dart';
import 'package:fast_contacts/fast_contacts.dart' as fcontacts;
import '../../../../core/errors/exceptions.dart';
import 'contact_db_datasource.dart';

abstract class ContactInfoDataSource {
  Future<List<OfflineContactInfoModel>> getAllContacts();
}

class ContactInfoDataSourceImpl implements ContactInfoDataSource {
  final ContactDataStore dataStore;
  ContactInfoDataSourceImpl({required this.dataStore});
  @override
  Future<List<OfflineContactInfoModel>> getAllContacts() async {
    var contactsPermission = await Permission.contacts.request();
    if (contactsPermission.isGranted) {
      final retrievedContacts = await fcontacts.FastContacts.getAllContacts();
      List<OfflineContactInfoModel> contacts = [];
      for (var contact in retrievedContacts) {
        contacts.add(
          OfflineContactInfoModel(
            id: contact.id,
            name: contact.displayName,
            phone: contact.phones.elementAtOrNull(0)?.number,
            bloodGroup: await dataStore.getBloodGroup(id: contact.id),
            locationCoordinates:
                await dataStore.getLocationCoordinates(id: contact.id),
          ),
        );
      }
      return contacts;
    } else {
      throw PermissionDeniedException();
    }
  }
}
