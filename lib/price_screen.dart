import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

extension WidgetModifier on Widget {
  Widget padding({EdgeInsetsGeometry value = const EdgeInsets.all(16)}) {
    return Padding(
      child: this,
      padding: value,
    );
  }
}

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'USD';
  Map<String, String> rates = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map<String, String> data = await CoinData().getRates(currentCurrency);
    setState(() {
      rates = data;
    });
  }

  List<Widget> buildRateCards() {
    return cryptoList
        .map((crypto) => RateCard(
            crypto: crypto,
            currency: currentCurrency,
            rate: rates[crypto] ?? '?'))
        .toList();
  }

  DropdownButton getDropdownButton() {
    return DropdownButton(
        value: currentCurrency,
        items: currenciesList
            .map(
              (currency) => DropdownMenuItem(
                child: Text(
                  currency,
                ),
                value: currency,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            currentCurrency = value;
          });
          getData();
        });
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 19),
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          currentCurrency = currenciesList[index];
        });
        getData();
      },
      children: currenciesList
          .map(
            (currency) => Text('$currency'),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildRateCards(),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:
                  Platform.isIOS ? getCupertinoPicker() : getDropdownButton()),
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  final String crypto;
  final String rate;
  final String currency;
  const RateCard({this.crypto, this.rate, this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.lightBlueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        '1 ${crypto ?? 'BTC'} = ${rate ?? '?'} ${currency ?? 'USD'}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ).padding(
          value: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0)),
    ).padding(value: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0));
  }
}
