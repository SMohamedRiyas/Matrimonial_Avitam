var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@ ActiveItZone " + this_year;
  static String app_name = "MATRIMONIAL";

  // enter string purchase_code here
  static String purshase_code = '43dd8d70-9f8b-45e0-b39f-4c1d5d7f4e4c';

  // configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "msttm.in"; //localhost

  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
