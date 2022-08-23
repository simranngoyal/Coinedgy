import 'package:http/http.dart' as http;
import 'dart:convert';

const key = '370FBF4E-8602-47A9-9B26-41FAC282D62B';

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
  String url = 'https://rest.coinapi.io/v1/exchangerate';
  Future getCoinData(String curr, String cryp) async {
    var rate;
    for(int i=0; i<3; i++){
      String requrl = '$url/$cryp/$curr?apikey=$key';

      http.Response ans = await http.get(Uri.parse(requrl));

      if(ans.statusCode == 200){
        var decoded = jsonDecode(ans.body);
        rate = decoded['rate'];
      }
      else {
        print(ans.statusCode);
      }
    }
    return rate;
  }
}