import 'package:url_launcher/url_launcher.dart';

import 'launch_call_interface.dart';

class URLLauncherLaunchCall implements LaunchCall {
  @override
  void callNumber({required String number}) {
    launchUrl(Uri.parse("tel:$number"));
  }
}
