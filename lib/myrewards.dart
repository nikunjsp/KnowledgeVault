import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'marketplace.dart';
import 'mycourses.dart';
import 'faq.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class myrewards extends StatefulWidget {
  const myrewards({Key? key}) : super(key: key);

  @override
  State<myrewards> createState() => _myrewardsState();
}

class _myrewardsState extends State<myrewards> {
  final double fontSize = 0.04;
  final double paddingVertical = 0.03;
  final double paddingHorizontal = 0.05;

  final DatabaseReference _myrewardsRef =
      FirebaseDatabase.instance.reference().child('Users');
  List<Reward> myrewardList = [];
  String userPoints = '';
  var userReward = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('Users');
        DatabaseReference rewardRef =
            FirebaseDatabase.instance.ref().child('RewardList');

        Query query = userRef.orderByChild('email').equalTo(user.email);

        DataSnapshot snapshot2 = (await query.once()).snapshot;
        Map<dynamic, dynamic>? userData =
            snapshot2.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          Map<dynamic, dynamic> userRecord = userData.values.first;

          if (userRecord.containsKey('userRewards')) {
            List<dynamic> userRewards = userRecord['userRewards'];
            Query query1 = rewardRef.orderByChild('index');
            DataSnapshot snapshot = (await query1.once()).snapshot;

            if (snapshot.value != null &&
                snapshot.value is Map<dynamic, dynamic>) {
              Map<dynamic, dynamic> data =
                  snapshot.value as Map<dynamic, dynamic>;
              List<Reward> fetchedmyRewards = [];

              userRewards.forEach((rewardIndex) {
                if (data.containsKey(rewardIndex.toString())) {
                  Reward reward = Reward.fromMap(data[rewardIndex.toString()]);
                  fetchedmyRewards.add(reward);
                }
              });

              setState(() {
                myrewardList = fetchedmyRewards;
                userPoints = userRecord['points'].toString();
              });
            }
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
                  itemCount: myrewardList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height) / (1 * 350),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(116, 85, 247, 0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myrewardList[index].name ?? '',
                              style: const TextStyle(
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              myrewardList[index].description ?? '',
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
                                  'Price: ${myrewardList[index].points}',
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  child: TextButton(
                                    onPressed: null,
                                    child: const Text(
                                      'Redeemed',
                                      style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        currentIndex: 0,
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
