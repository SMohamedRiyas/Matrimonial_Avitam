// import 'dart:convert';
//
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
//
// class PpChartsInfo extends StatefulWidget {
//   const PpChartsInfo({super.key});
//
//   @override
//   State<PpChartsInfo> createState() => _PpChartsInfoState();
// }
//
// class _PpChartsInfoState extends State<PpChartsInfo> {
//   Future<void> fetchdata() async {
//     final res = await http.get(Uri.parse(
//         "https://jyotish-software.s3.ap-south-1.amazonaws.com/Chart_1727774906588.svg"));
//     setState(() {
//       data = jsonDecode(res.body);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchdata();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           image: DecorationImage(
//             image: NetworkImage(data[index]['']),
//           )),
//     );
//   }
// }
class PpChartsInfo extends StatelessWidget {
  const PpChartsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
