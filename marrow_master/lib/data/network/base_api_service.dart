abstract class BaseApiServices {
  Future<dynamic> getApi({
    required String url,
    Map<String, String>? header,
  });

  Future<dynamic> postApi(
      {required dynamic data,
      Map<String, String>? header,
      required String url});

  Future<dynamic> putApi(
      {required dynamic data,
      Map<String, String>? header,
      required String url});
}
