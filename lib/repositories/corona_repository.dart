import 'dart:convert';
import 'dart:io';

import 'package:flutcor/models/models.dart';
import 'package:http/http.dart' as http;

class CoronaRepository {
  final String _baseUrl = 'https://apigw.nubentos.com:443';

  Future<TokenModel> getToken() async {
    String _tokenUrl = '$_baseUrl/token';
    var _header = {
      HttpHeaders.authorizationHeader:
          'Basic WnFodW02YXVYNGt0UXdxQ2pleGNISDFDTWg4YToxeFk4U1IyeGp0RExMTl9PUHRnWG53N1IxNmNh'
    };
    var _response = await http.post(_tokenUrl,
        headers: _header, body: {'grant_type': 'client_credentials'});
    return TokenModel.fromJson(_response.body);
  }

  getData(TokenModel token, String flag) async {
    var _accessToken = token.accessToken;
    var _url = '$_baseUrl/t/nubentos.com/ncovapi/2.0.0/$flag';
    var _header = {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
    var _response = await http.get(_url, headers: _header);
    var _data = jsonDecode(_response.body);
    return _data[0]['data'];
  }

  /* getCases(TokenModel token) async {
    var _accessToken = token.accessToken;
    var _url = '$_baseUrl/t/nubentos.com/ncovapi/2.0.0/cases';
    var _header = {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
    var _response = await http.get(_url, headers: _header);
    var _data = jsonDecode(_response.body);
    print(_data);
    return _data[0]['data'];
  }

  getRecovered(TokenModel token) async {
    var _accessToken = token.accessToken;
    var _url = '$_baseUrl/t/nubentos.com/ncovapi/2.0.0/recovered';
    var _header = {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
    var _response = await http.get(_url, headers: _header);
    var _data = jsonDecode(_response.body);
    return _data[0]['data'];
  }

  getDeaths(TokenModel token) async {
    var _accessToken = token.accessToken;
    var _url = '$_baseUrl/t/nubentos.com/ncovapi/2.0.0/deaths';
    var _header = {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
    var _response = await http.get(_url, headers: _header);
    var _data = jsonDecode(_response.body);
    return _data[0]['data'];
  } */
  
}
