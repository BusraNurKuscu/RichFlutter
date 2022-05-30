import 'package:flutter/material.dart';

import 'main.dart';

class KarZarar extends StatefulWidget {
  KarZarar({Key? key}) : super(key: key);

  @override
  State<KarZarar> createState() => _KarZararState();
}

class _KarZararState extends State<KarZarar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const Text(
      "Kar Zarar",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue),
      textAlign: TextAlign.center,
    ),
        IconWidget(
          Icons.add_chart,
          ' ',
        ),
        const Text(
          "VARLIKLARIM",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(5),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blueAccent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
//margin: EdgeInsets.only(left: 20),
                  child: const Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "Türk Lirası",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                       girisYapilanTopamTLTutar.toString() + " ₺",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                     // Container(
                    //    margin: const EdgeInsets.all(5),
                   //     child: const Icon(Icons.add,
                   //         size: 30, color: Colors.greenAccent),
                   //   ),
                   //   Container(
               //         margin: const EdgeInsets.all(5),
               //         child: const Icon(Icons.edit,
              //              size: 30, color: Colors.greenAccent),
              //        ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: const Icon(Icons.money_outlined,
                            size: 30, color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(5),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blueAccent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
//margin: EdgeInsets.only(left: 20),
                  child: const Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "Döviz",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        girisYapilanTopamDoviz.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        "Kar zarar",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        (girisYapilanTopamSabitKurTutar - girisYapilanTopamDoviz ).toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                   //   Container(
                       // margin: const EdgeInsets.all(5),
                     //   child: const Icon(Icons.add,
                     //       size: 30, color: Colors.greenAccent),
                   //   ),
                  //    Container(
                    //    margin: const EdgeInsets.all(5),
                      //  child: const Icon(Icons.edit,
                        //    size: 30, color: Colors.greenAccent),
                     // ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: const Icon(Icons.monetization_on,
                            size: 30, color: Colors.greenAccent),
                      ),

                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  IconWidget(this.iconData, this.description);

  final IconData iconData;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(10),
          ),
          Icon(
            iconData,
            size: 160,
            color: Colors.red,
          ),
          Text(description),
        ],
      ),
    );
  }
}

