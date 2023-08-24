// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rayab2bupdated/Constants/Constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Contact Us",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: MyColorsSample.fontColor,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Image.asset(
              'assets/contact.jpg',
              height: 250,
            )),
            const SizedBox(
              height: 10,
            ),
            Text(
              'If you need help \n feel free to contact us',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                        )
                      ]),
                      height: 100,
                      width: 150,

                      //color: Colors.white,
                      child:  const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alternate_email,
                            color: MyColorsSample.fontColor,
                            size: 50,
                          ),
                          Text(
                            'Raya@rayacorp.com',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      )
                    ]),
                    height: 100,
                    width: 150,
                    // color: Colors.white,
                    child:  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help,
                          color: MyColorsSample.fontColor,
                          size: 50,
                        ),
                        Text('FAQs'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      )
                    ]),
                    height: 100,
                    width: 150,
                    // color: Colors.white,
                    child:  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: MyColorsSample.fontColor,
                          size: 50,
                        ),
                        Text('+200111214214 '),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      )
                    ]),
                    //color: Colors.white,
                    child:  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: MyColorsSample.fontColor,
                          size: 50,
                        ),
                        Text('Raya '),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
