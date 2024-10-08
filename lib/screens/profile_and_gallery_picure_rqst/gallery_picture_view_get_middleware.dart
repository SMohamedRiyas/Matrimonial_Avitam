import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/gallery_picture_view_request_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/gallery_picture_view_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../helpers/main_helpers.dart';

ThunkAction<AppState> getGalleryPictureViewRequestMiddleware({page = 1}) {
  return (Store<AppState> store) async {
    // store.dispatch(GetGalleryPictureViewAction());
    try {
      var data = await GalleryPictureViewRepository()
          .getGalleryPictureViewRequestList(page: page);
      store.dispatch(
          GetGalleryPictureViewSucceededAction(gallerypictureviewlist: data));
    } catch (e) {
      store.dispatch(GetGalleryPictureViewFailureAction(error: e.toString()));
      return;
    }
  };
}

class GalleryPictureViewRepository {
  Future<GalleryPictureViewRequestGetResponse> getGalleryPictureViewRequestList(
      {page}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/gallery-image-view-request?page=$page";
    var accessToken = getToken;
    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      });

      // print(response.body);
      var data = galleryPictureViewRequestGetResponseFromJson(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
