

abstract class BaseApiService{
  Future<dynamic> getGetResponse(String url);
  Future<dynamic> getPostApiResponse(String url, Map<String, String> data);
  Future<dynamic> getPostApiResponseWithoutParam(String url);
  Future<dynamic> getPostApiResponseRaw(String url, dynamic data);


}