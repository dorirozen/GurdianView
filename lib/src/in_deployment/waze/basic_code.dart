//https://waze.com/ul?ll=[latitude],[longitude]&navigate=yes
/*
ll: This parameter takes the latitude and longitude of the destination.
 Replace [latitude] and [longitude] with the actual coordinates.
navigate: Set to yes to start navigation immediately.
 If omitted or set to no, Waze will only display the location without starting navigation.
An example URL to navigate to a location with latitude 40.758896 and
 longitude -73.985130 would look like this:
 */
//https://waze.com/ul?ll=40.758896,-73.985130&navigate=yes

/// how to implement
/*
import 'package:url_launcher/url_launcher.dart';

...

void launchWaze(double latitude, double longitude) async {
  final url = 'https://waze.com/ul?ll=$latitude,$longitude&navigate=yes';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Handle the situation when Waze can't be launched (e.g., not installed)
  }
}

 */
