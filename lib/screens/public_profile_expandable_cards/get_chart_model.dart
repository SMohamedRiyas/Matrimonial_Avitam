import 'dart:convert'; // for jsonEncode

import 'package:http/http.dart' as http;

Future<void> sendRequest({
  required String year,
  required String month,
  required String date,
  required String hours,
  required String minutes,
  required String seconds,
  required double latitude,
  required double longitude,
  required double timezone,
}) async {
  // Define the API URL
  var url = Uri.parse(
      'https://json.apiastro.com/planets?=LrpCU2u2099RgZvAo4aRZ1C2sppPbbqF6rl1FkX5'); // Replace with your API URL

  // Create the body of the request
  var body = jsonEncode({
    "year": 1976,
    "month": 6,
    "date": 10,
    "hours": 11,
    "minutes": 10,
    "seconds": 0,
    "latitude": 18.933,
    "longitude": 72.8166,
    "timezone": 5.5,
    "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
  });

  try {
    // Send a POST request to the API
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set content type to JSON
      },
      body: body,
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Successfully received response
      var jsonResponse = jsonDecode(response.body);
      print('Response from API: $jsonResponse');
    } else {
      // Handle error response
      print('Failed to send request. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any error that occurred during the request
    print('Error occurred: $error');
  }
}
