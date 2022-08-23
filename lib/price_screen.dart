import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurr = 'INR';
  String selectedCryp = 'BTC';

  DropdownButton<String> dropdown(){
    List<DropdownMenuItem<String>> list1 = [];

    for(int i=0; i<currenciesList.length; i++){
      var newItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i]
      );
      list1.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurr,
        style: TextStyle(
          color: Colors.black,
        ),
        alignment: Alignment.center,
        items: list1,
        icon: const Icon(
            Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        onChanged: (value){
          setState(() {
            selectedCurr = value!;
            getData();
          });
        }
    );
  }

  DropdownButton<String> dropdown2(){
    List<DropdownMenuItem<String>> list2 = [];

    for(int i=0; i<cryptoList.length; i++){
      var newItem = DropdownMenuItem(
          child: Text(cryptoList[i]),
          value: cryptoList[i]
      );
      list2.add(newItem);
    }
    return DropdownButton<String>(
        items: list2,
        value: selectedCryp,
        style: TextStyle(
          color: Colors.black,
        ),
        alignment: Alignment.center,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        onChanged: (value){
          setState(() {
            selectedCryp = value!;
            getData();
          });
        }
    );
  }

  String crp = '';
  String inp = ''; // = Text(controller.text).toString();
  double res = 0;

  void getData() async {
    try {
      double rate = await CoinData().getCoinData(selectedCurr, selectedCryp);
      setState(() {
        crp = rate.toStringAsFixed(0);
        res = double.parse(crp) * (double.parse(inp));
      });
    }
    catch(e){
      print(e);
    }
  }

  print(res) {
    // TODO: implement print
    throw UnimplementedError();
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COINEDGY',
          textAlign: TextAlign.right,
        ),
        backgroundColor: const Color.fromARGB(255, 6, 35, 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                          'Your Currency',
                          style: TextStyle(
                              color: Color(0xff908D8C)
                          )
                      ),
                      TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          onChanged: (value){
                            setState(() {
                              inp = value;
                            });
                          }
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                          'Crypto Currency',
                          style: TextStyle(
                              color: Color(0xff908D8C)
                          )
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Text(
                        res.toString(),
                        style: const TextStyle(
                          color: Colors.black
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dropdown(),
                const SizedBox(
                  width: 5,
                ),
                dropdown2()
                //dropdown2()
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 30),
              padding: const EdgeInsets.all(10),

              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xffE9E9E7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'RATE',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '1 $selectedCurr = $crp $selectedCryp',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 6, 35, 32)
              ),
              child: const Text(
                'SWAP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
