import 'services/network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Map<String, String> data = {};

  Future<Map<String, String>> getRates(String currentCurrency) async {
    for (String crypto in cryptoList) {
      data[crypto] = await NetworkHelper()
          .getRate(crypto: crypto, currency: currentCurrency);
    }
    return data;
  }
}
