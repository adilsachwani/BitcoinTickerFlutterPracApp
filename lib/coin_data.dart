import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/";

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
  Future getCurrencyData(String currency) async {
    Map<String, String> cryptoRates = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(URL + crypto + currency);
      if (response.statusCode == 200) {
        double price = convert.jsonDecode(response.body)['last'];
        cryptoRates[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoRates;
  }
}
