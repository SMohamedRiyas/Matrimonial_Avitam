import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class PpChartsInfo extends StatelessWidget {
  final String svgUrl;

  PpChartsInfo({required this.svgUrl});

  Future<String> fetchSvgData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load SVG');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchSvgData(svgUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasError) {
          return const Icon(Icons.error,
              color: Colors.red, size: 72); // Show error icon
        } else if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data!,
            height: 72,
            width: 72,
            fit: BoxFit.contain,
          );
        } else {
          return const Icon(Icons.error,
              color: Colors.red, size: 72); // Fallback for unexpected cases
        }
      },
    );
  }
}
