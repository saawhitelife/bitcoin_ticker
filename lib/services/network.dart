import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitcoin_ticker/settings.dart';
import 'dart:math';

class NetworkHelper {
  Future<String> getRate({String crypto, String currency}) async {
    String url =
        '$kCoinRestApiUrl/exchangerate/$crypto/$currency?apikey=$kCoinApiKey';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      var decoded = jsonDecode(body);
      double rate = decoded['rate'];
      String rateOut = rate.toStringAsFixed(2);
      return rateOut;
    } else {
      print(response.statusCode);
      throw 'Error happened when fetching data from network';
    }

    /// Use this to test with no api consuming
    //await Future.delayed(Duration(seconds: 1));
    //return Random().nextInt(100).toString();
  }
}
