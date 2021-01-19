import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  String rateBTC = '?';
  String rateETH = '?';
  String rateLTC = '?';
  CoinData ETH = new CoinData(cryptoCurrency: 'ETH');
  CoinData BTC = new CoinData(cryptoCurrency: 'BTC');
  CoinData LTC = new CoinData(cryptoCurrency: 'LTC');

  @override
  void initState() {
    super.initState();
    firstRun();
    //String calculatedETH = await updateETH(selectedCurrency, context);
    //String calculatedLTC = await updateLTC(selectedCurrency, context);

  }

  void firstRun() async {
    String calculatedBTC = await updateBTC(selectedCurrency, context);
    String calculatedETH = await updateETH(selectedCurrency, context);
    String calculatedLTC = await updateLTC(selectedCurrency, context);
    setState(() {
      rateBTC = calculatedBTC;
      rateETH = calculatedETH;
      rateLTC = calculatedLTC;
    });
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (index) async {
      String calculatedBTC = await updateBTC(currenciesList[index], context);
      String calculatedETH = await updateETH(currenciesList[index], context);
      String calculatedLTC = await updateLTC(currenciesList[index], context);
      setState(() {
      selectedCurrency = currenciesList[index];
      rateBTC = calculatedBTC;
      rateETH = calculatedETH;
      rateLTC = calculatedLTC;
      });}, children: pickerList,);
  }

  DropdownButton androidDropdown(){
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dopdrownCurrencyList,
        onChanged: (value) async {
          String calculatedBTC = await updateBTC(value, context);
          String calculatedETH = await updateETH(value, context);
          String calculatedLTC = await updateLTC(value, context);
          setState(() {
            selectedCurrency = value;
            rateBTC = calculatedBTC;
            rateETH = calculatedETH;
            rateLTC = calculatedLTC;
          });
        });
  }

  Future<String> updateBTC(String value, BuildContext context) async{
    return await BTC.getRate(value, context);
  }
  Future<String> updateETH(String value, BuildContext context) async{
    return await ETH.getRate(value, context);
  }
  Future<String> updateLTC(String value, BuildContext context) async{
    return await LTC.getRate(value, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                buildCard(rateBTC, 'BTC'),
                Divider(height: 20),
                buildCard(rateETH, 'ETH'),
                Divider(height: 20),
                buildCard(rateLTC, 'LTC'),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  Card buildCard(String value, String crypto) {
    return Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $crypto = $value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}