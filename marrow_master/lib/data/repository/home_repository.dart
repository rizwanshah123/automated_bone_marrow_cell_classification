import '../network/network_api_service.dart';

class HomeRepository {
  final _apiService = NetworkApiService();

  uploadImage(var imagePath) async {
    print("Inside the Repository Class");
    // print(imagePath);
    print("inside the uploadImage method");
    dynamic response = await _apiService.postApi(
        url: "http://192.168.147.90:5000/process-image", data: imagePath);

    print("Response is $response");
    //print("Inside Home Repository " + response);
    return response;
  }
}
// http://10.0.2.2:5000/process-image