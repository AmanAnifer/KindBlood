import 'package:permission_handler/permission_handler.dart';
import '../models/contact_info_model.dart';
import 'package:fast_contacts/fast_contacts.dart' as fcontacts;
import '../../../../core/errors/exceptions.dart';
import 'package:kindblood/core/database/contact_db/contact_db_interface.dart';

abstract class ContactInfoDataSource {
  Future<List<ContactInfoModel>> getAllContacts();
}

class ContactInfoDataSourceImpl implements ContactInfoDataSource {
  final ContactDataStore dataStore;
  ContactInfoDataSourceImpl({required this.dataStore});
  @override
  Future<List<ContactInfoModel>> getAllContacts() async {
    var contactsPermission = await Permission.contacts.request();
    if (contactsPermission.isGranted) {
      final retrievedContacts = await fcontacts.FastContacts.getAllContacts();
      List<ContactInfoModel> contacts = [];
      for (var contact in retrievedContacts) {
        contacts.add(
          ContactInfoModel(
            name: contact.displayName,
            phone: contact.phones.first.number,
            bloodGroup: await dataStore.getBloodGroup(
                phoneNumber: contact.phones.first.number),
            locationGeohash: await dataStore.getLocationGeoHash(
                phoneNumber: contact.phones.first.number),
          ),
        );
      }
      return contacts;
    } else {
      throw PermissionDeniedException();
    }
  }
}
