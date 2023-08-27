import 'package:fast_contacts/fast_contacts.dart' as fcontacts;
import 'package:permission_handler/permission_handler.dart';
import 'package:kindblood_common/core_entities.dart';
import '../../../../core/errors/exceptions.dart';
import 'offline_contact_db_datasource.dart';

abstract class OfflineContactInfoDataSource {
  Future<List<ContactInfo>> getAllContacts();
}

class OfflineContactInfoDataSourceImpl implements OfflineContactInfoDataSource {
  final OfflineContactDataStore dataStore;
  OfflineContactInfoDataSourceImpl({required this.dataStore});
  @override
  Future<List<ContactInfo>> getAllContacts() async {
    var contactsPermission = await Permission.contacts.request();
    if (contactsPermission.isGranted) {
      final retrievedContacts = await fcontacts.FastContacts.getAllContacts();
      List<ContactInfo> contacts = [];
      for (var contact in retrievedContacts) {
        contacts.add(
          ContactInfo(
            id: contact.id,
            contactSourceType: ContactSourceType.offline,
            name: contact.displayName,
            phoneNumber: contact.phones.elementAtOrNull(0)?.number,
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
