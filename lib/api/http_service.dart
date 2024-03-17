import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/utils/app_exceptions.dart';

class HttpService {
  Future<dynamic> getApi({required String url}) async {
    var uri = Uri.parse(url);
    try {
      var response = await http.get(uri, headers: {
        "Authorization":
            "CMx1IzLKjSwoEu8I3KkbrFjazFqEVAoDJ3WASYCGOeRILc6jPUb416IH"
      });
      return await returnJsonResponse(response);
    } on SocketException catch (ex) {
      throw (FetchDataException(errormMsg: "No internet: ${ex.toString()}"));
    }
  }

  Future<dynamic> returnJsonResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        {
          var data = jsonDecode(response.body);
          return data;
        }
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
        throw UnauthorizedException(errorMsg: response.body.toString());
      case 403:
        throw UnauthorizedException(errorMsg: response.body.toString());
      case 500:
        throw FetchDataException(errormMsg: response.body.toString());
      default:
        throw FetchDataException(errormMsg: response.body.toString());
    }
  }
}
