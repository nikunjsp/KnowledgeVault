import 'package:flutter/material.dart';
import 'package:knowledgevault/myrewards.dart';
import 'models/Rewards.dart';
import 'models/redeemReward.dart';
import 'package:knowledgevault/myrewards.dart';

class redeemItem extends StatefulWidget {
  const redeemItem({Key? key});

  @override
  State<redeemItem> createState() => _redeemItemState();
}

class _redeemItemState extends State<redeemItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Rewards'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.business_center,
                      size: 20,
                      color: Color.fromRGBO(116, 85, 247, 1),
                    ),
                    Text(
                      "1000",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(116, 85, 247, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: redeemRewardlist.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height) / (1 * 1500),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(24, 255, 255, 255),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/icons/${redeemRewardlist[index].picture}.jpg',
                                width: 250,
                                height: 300,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  redeemRewardlist[index].rewardname,
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.justify,
                              redeemRewardlist[index].description,
                              style: const TextStyle(
                                fontFamily: 'RobotoMono',
                                fontStyle: FontStyle.italic,
                                fontSize: 10,
                                color: Color.fromRGBO(131, 136, 139, 1),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(300, 20),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const myrewards()),
                                  );
                                },
                                child: const Text('Redeem Now'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
