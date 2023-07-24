import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'myrewards.dart';
import 'mycourses.dart';
import 'faq.dart';
import 'package:knowledgevault/redeemItem.dart';
import 'HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class marketplace extends StatefulWidget {
  const marketplace({super.key});

  @override
  State<marketplace> createState() => _marketplaceState();
}

class _marketplaceState extends State<marketplace> {
  final DatabaseReference _rewardsRef =
      FirebaseDatabase.instance.reference().child('RewardList');
  List<Reward> rewardList = [];
  String userPoints = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      DatabaseEvent event = await _rewardsRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Reward> fetchedRewards = [];
        data.forEach((key, value) {
          Reward reward = Reward.fromMap(value);
          fetchedRewards.add(reward);
        });

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
              rewardList = fetchedRewards;
              userPoints = userRecord['points'].toString();
            });
          }
        }
      }
    } catch (error) {
      print('Error fetching rewards data: $error');
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
        title: Text('Marketplace'),
        automaticallyImplyLeading: false,
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
      body: Container(
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
                  itemCount: rewardList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
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
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              
                                              Text(
                              rewardList[index].name ?? '',
                              style: const TextStyle(
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              rewardList[index].description ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily: 'RobotoMono',
                                fontStyle: FontStyle.italic,
                                fontSize: 10,
                                color: Color.fromRGBO(131, 136, 139, 1),
                              ),
                            ),               
                              
                            const SizedBox(height: 10),               
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price: ${rewardList[index].points}',
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(116, 85, 247, 1),
                                    foregroundColor: Colors.white,
                                    textStyle: const TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => redeemItem(
                                                  name:
                                                      rewardList[index].name ??
                                                          '',
                                                  description: rewardList[index]
                                                          .description ??
                                                      '',
                                                  picture: rewardList[index]
                                                          .picture ??
                                                      '',
                                                  points: rewardList[index]
                                                          .points ??
                                                      0,
                                                  redeemRewardKey: index,
                                                )));
                                  },
                                  child: const Text('Redeem Now'),
                                ),
                              ],
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        showUnselectedLabels: true,
        selectedItemColor: const Color.fromRGBO(116, 85, 247, 1),
        selectedFontSize: 12,
        unselectedItemColor: const Color.fromRGBO(131, 136, 139, 1),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_sharp), label: 'My Rewards'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_outlined), label: 'Marketplace'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'My Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined), label: 'FAQs'),
        ],
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const myrewards()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const marketplace()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const mycourses()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => faq()),
            );
          }
        },
      ),
    );
  }
}

class Reward {
  String? description;
  String? name;
  int? points;
  String? picture;

  Reward({
    this.description,
    this.name,
    this.points,
    this.picture,
  });

  factory Reward.fromMap(Map<dynamic, dynamic> map) {
    return Reward(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      points: map['points'] ?? '',
      picture: map['picture'] ?? '',
    );
  }
}
