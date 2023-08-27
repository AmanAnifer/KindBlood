## 2023-05-18
So we want the first page to be offline contacts which shows the contacts currently in device and its blood type, if it exists in database. Initial idea was to use custom fields in vcf as a storage for blood type but no library for flutter currently supports that, and also iOS doesnt allow easily editing contacts or something. So store blood details in internal database.  

* Feature idea: QR code to share our blood info, so that others with app can scan our code and they will get our blood info and save contact

when click contact, display info, call button, edit button to add blood type

in online mode, many modes  
* one where phone number stored in plaintext, so anyone can get the number by looking for blood  
* one where phone number stored in hash. when someone requests for blood, this request sent to that hashed number person, along with the (or stored in server) the requester's number, volunteer can then accept and then call requester's number.  
* online update : user sends hashes of their local numbers and if hashes match those in server database (i think we should rehash this hash with salt and store that instead for more privacy), send blood info back to user, so user can have updated info of their local contacts, which can then be used offline

## 2023-05-20
### Parameters
* Blood type: selects the blood type to search for, defaults to users "my info" details blood type. When clicked, opens a dialog to select blood
* Offline/Online toggle: Toggle Chip which selects the mode, if offline, shows only offline contacts; if online, show only online contacts
* Within x km: Dialog button to select the maximum distance from user, maybe show a slider or something.
* Compatibility x: Three options for blood compatibility, Same type/Compatible type, all type.  
( ( ( same ) compatible ) all ), ie  
_same_ subset of _compatible_ subset of _all_
