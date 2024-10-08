import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/public_profile_response.dart';
import 'package:http/http.dart' as http;

import '../helpers/main_helpers.dart';

class PublicProfileRepository {
  Future<PublicProfileResponse> fetchPublicProfile(
      {required int userId}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/public-profile/$userId";
    var accessToken = getToken;

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });
    var data = publicProfileResponseFromJson(response.body);
    return data;
  }
}
