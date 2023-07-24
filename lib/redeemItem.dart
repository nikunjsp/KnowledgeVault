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
      body: Container ( 
      height: double.infinity,
      child : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: redeemRewardlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},

                      child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(116, 85, 247, 0.1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              widget.picture,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              
                                              Text(
                        '${widget.name}',
                        style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.black,
                        ),
                      ),
                                              const SizedBox(height: 10),
                                              
                                              Text(
                        '${widget.description}',
                        style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Color.fromRGBO(131, 136, 139, 1),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                                  int redeemRewardKey = widget.redeemRewardKey;
                                  updatePoints(updatedUserPoints, redeemRewardKey);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Insufficient Points'),
                                      content: const Text(
                                          'You do not have enough points to redeem this reward.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
    ),
    );
  }
}
