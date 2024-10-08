import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class PpChartsInfo extends StatefulWidget {
  const PpChartsInfo({super.key});

  @override
  _PpChartsInfoState createState() => _PpChartsInfoState();
}

class _PpChartsInfoState extends State<PpChartsInfo> {
  String? imageUrl;
  String errorMessage = '';

  // Function to call the API and update the image URL
  Future<void> sendRequest() async {
    var url =
        'https://json.apiastro.com/horoscope-chart-url'; // Corrected query parameter

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
      "config": {
        "observation_point": "topocentric",
        /* topocentric / geocentric */
        "ayanamsha": "lahiri" /* lahiri / sayana */
      }
    });
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'LrpCU2u2099RgZvAo4aRZ1C2sppPbbqF6rl1FkX5'
        },
        body: body,
      );
    } catch (error) {
      setState(() {
        errorMessage = 'An error occurred: $error';
        imageUrl = null;
      });
    }
    if (response?.statusCode == 200) {
      var jsonResponse = jsonDecode(response!.body);
      print('value = $jsonResponse');
      if (jsonResponse.containsKey('output')) {
        setState(() {
          imageUrl = jsonResponse['output']; // Correct field
          errorMessage = ''; // Clear error message
        });
      } else {
        setState(() {
          errorMessage = 'Image URL not found in the response';
          imageUrl = null;
        });
      }
    } else {
      setState(() {
        errorMessage = 'Request failed with status: ${response?.statusCode}';
        imageUrl = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sendRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imageUrl != null
          ? SvgPicture.network(
              imageUrl!, // Use SvgPicture to load the SVG
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
              fit: BoxFit.cover,
            )
          : errorMessage.isNotEmpty
              ? Text(errorMessage) // Show error message if any
              : const CircularProgressIndicator(),
    );
  }
}
