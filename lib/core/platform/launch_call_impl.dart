import 'package:url_launcher/url_launcher_string.dart';

import 'launch_call_interface.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherLaunchCall implements LaunchCall {
  @override
  void callNumber({required String number}) {
    launchUrl(Uri.parse("tel:$number"));
  }
}
