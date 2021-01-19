import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

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

const List<String> currenciesLongnameList = [
  'Australian Dollar',
  'Brazil Real',
  'Canadian Dollar',
  'Chinese Yuan',
  'Euro',
  'British Pound',
  'Hong Kong Dollar',
  'Indonesian Rupiah',
  'Israeli Sheqel',
  'Indian Rupee',
  'Japanese Yen',
  'Mexican Peso',
  'Norwegian Krone',
  'New Zealand Dollar',
  'Polish złoty',
  'Romanian Leu',
  'Russian Rubble',
  'Swedish Krone',
  'Singaporean Dollar',
  'US Dollar',
  'South African Rand'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


List<DropdownMenuItem<String>> get dopdrownCurrencyList{
  List<DropdownMenuItem<String>> list = [];
  for(int i = 0; i < currenciesList.length; i++){
    list.add(DropdownMenuItem(child: Text(currenciesLongnameList[i]), value: currenciesList[i]));
  }
  return list;
}

List<Widget> get pickerList{
  List<Widget> list = [];
  for(String currency in currenciesLongnameList){
    list.add(Text(currency, style: TextStyle(color: Colors.white),));
  }
  return list;
}

const String apiKEY = 'A614F8C6-5A45-4CAF-8929-D0823AF4C7FE';
const String apiKEY2 = '5EE4EF59-E73B-43FC-91D3-0AE29989A2E1';

class CoinData {
  final String cryptoCurrency;
  CoinData({this.cryptoCurrency});

  Future<String> getRate(String fiatCurrency, BuildContext context) async {
    dynamic json;
    String exchangeURL = 'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$fiatCurrency?apikey=$apiKEY';
    http.Response response = await http.get(exchangeURL);
    if(response.statusCode!= 200){
      Toast.show("We can't fetch the data. Check your internet connection.", context, gravity:  Toast.BOTTOM);
    }else{
       var json = jsonDecode(response.body);
       double rate = json['rate'];
       print(rate);
       return rate.toStringAsFixed(2);
    }
  }
}
