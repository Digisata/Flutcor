import 'dart:io';

import 'package:flutcor/models/models.dart';
import 'package:http/http.dart' as http;

class CoronaRepository {
  final String _baseUrl = 'https://covid19.mathdro.id/api';

  getMainData() async {
    try {
      final http.Response _response = await http.get(_baseUrl);

      assert(_response != null);
      if (_response.statusCode == 400)
        throw Exception('Validation exception eccoured');
      else if (_response.statusCode == 404)
        throw Exception('Data not found');
      else if (_response.statusCode == 200) {
        final CoronaModel _coronaModel = CoronaModel.fromJson(_response.body);
        assert(_coronaModel != null);
        return _coronaModel;
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

  getDetailData(String url) async {
    try {
      final http.Response _response = await http.get(url);

      assert(_response != null);
      if (_response.statusCode == 400)
        throw Exception('Validation exception eccoured');
      else if (_response.statusCode == 404)
        throw Exception('Data not found');
      else if (_response.statusCode == 200) {
        final List<DetailModel> _detailModel =
            detailDataFromJson(_response.body);
        assert(_detailModel != null);
        return _detailModel;
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
