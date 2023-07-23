import 'package:flutter/material.dart';
import 'package:knowledgevault/myrewards.dart';
import 'models/redeemReward.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class redeemItem extends StatefulWidget {
  late final String name;
  late final String picture;
  late final String description;
  late final int points;
  late final int redeemRewardKey;

  redeemItem({
    required this.name,
    required this.description,
    required this.points,
    required this.picture,
    required this.redeemRewardKey,
  });

  @override
  State<redeemItem> createState() => _redeemItemState();
}

class _redeemItemState extends State<redeemItem> {
  String userPoints = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('Users');
      Query query = userRef.orderByChild('email').equalTo(user.email);

      DataSnapshot snapshot2 = (await query.once()).snapshot;
      Map<dynamic, dynamic>? userData =
          snapshot2.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        Map<dynamic, dynamic> userRecord = userData.values.first;

        setState(() {
          userPoints = userRecord['points'].toString();
        });
      }
    }
  }

  void updatePoints(int updatedUserPoints, int redeemRewardKey) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('Users');
      Query query = userRef.orderByChild('email').equalTo(user.email);

      DataSnapshot snapshot = (await query.once()).snapshot;
      Map<dynamic, dynamic>? userData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        String userId = userData.keys.first;
        Map<dynamic, dynamic> userRecord = userData.values.first;
        List<dynamic> userRewards = List.from(userRecord['userRewards'] ?? []);

        userRewards.add(redeemRewardKey);

        userRef.child(userId).update({
          'points': updatedUserPoints,
          'userRewards': userRewards,
        }).then((_) {
          setState(() {
            userPoints = updatedUserPoints.toString();
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => myrewards()),
          );
        }).catchError((error) {
          print('Failed to update points: $error');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Rewards'),
        actions: [
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
                      userPoints,
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
                              child: Image.network(
                                widget.picture,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.name}',
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
                              '${widget.description}',
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
                                  int requiredPoints = widget.points;
                                  if (int.parse(userPoints) >= requiredPoints) {
                                    int updatedUserPoints =
                                        int.parse(userPoints) - requiredPoints;
                                    int redeemRewardKey =
                                        widget.redeemRewardKey;
                                    updatePoints(
                                        updatedUserPoints, redeemRewardKey);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text('Insufficient Points'),
                                        content: const Text(
                                            'You do not have enough points to redeem this reward.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
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
