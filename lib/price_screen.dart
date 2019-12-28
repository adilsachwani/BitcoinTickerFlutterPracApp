import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = new CoinData();
  String selectedCurrency = "USD";
  Map<String, String> coinRates = {};
  bool isWaiting = false;
  @override
  void initState() {
    super.initState();
    updateData();
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
          getItemsList(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdownButton(),
          )
        ],
      ),
    );
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownMenuItemList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenuItemList.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItemList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        updateData();
      },
    );
  }

  Column getItemsList() {
    List<Widget> itemsList = [];
    for (String crypto in cryptoList) {
      var rate = isWaiting ? "?" : coinRates[crypto];
      var currentItem = Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = $rate $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      itemsList.add(currentItem);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: itemsList,
    );
  }

  void updateData() async {
    isWaiting = true;
    var rate = await coinData.getCurrencyData(selectedCurrency);
    isWaiting = false;
    setState(() {
      coinRates = rate;
    });
  }
}
