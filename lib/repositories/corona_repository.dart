import 'dart:convert';
import 'dart:io';

import 'package:flutcor/models/models.dart';
import 'package:http/http.dart' as http;

class CoronaRepository {
  final String _baseUrl = 'https://apigw.nubentos.com:443';

  getToken() async {
    String _tokenUrl = '$_baseUrl/token';
    Map<String, String> _header = {
      HttpHeaders.authorizationHeader:
          'Basic WnFodW02YXVYNGt0UXdxQ2pleGNISDFDTWg4YToxeFk4U1IyeGp0RExMTl9PUHRnWG53N1IxNmNh'
    };
    try {
      http.Response _response = await http.post(_tokenUrl,
          headers: _header, body: {'grant_type': 'client_credentials'});
      assert(_response != null);
      if (_response.statusCode == 400)
        throw Exception('Validation exception eccoured');
      else if (_response.statusCode == 404)
        throw Exception('Data not found');
      else if (_response.statusCode == 200)
        return TokenModel.fromJson(_response.body);
    } on SocketException {
      throw 'No internet';
    } on HttpException {
      throw 'No service found';
    } on FormatException {
      throw 'Invalid data format';
    } catch (error) {
      throw 'Unknown exceprion: $error';
    }
  }

  getData(TokenModel token, String flag) async {
    String _accessToken = token.accessToken;
    String _url = '$_baseUrl/t/nubentos.com/ncovapi/2.0.0/$flag';
    Map<String, String> _header = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_accessToken'
    };
    try {
      http.Response _response = await http.get(_url, headers: _header);

      assert(_response != null);
      if (_response.statusCode == 400)
        throw Exception('Validation exception eccoured');
      else if (_response.statusCode == 404)
        throw Exception('Data not found');
      else if (_response.statusCode == 200) {
        var _data = jsonDecode(_response.body);
        return _data[0]['data'];
      }
    } on SocketException {
      throw 'No internet';
    } on HttpException {
      throw 'No service found';
    } on FormatException {
      throw 'Invalid data format';
    } catch (error) {
      throw 'Unknown exceprion: $error';
    }
  }
}
