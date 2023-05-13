import 'dart:math';
import 'package:araigordaiwithme/screens/pages/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

class RandomButton extends StatefulWidget {
  const RandomButton({super.key});

  @override
  State<RandomButton> createState() => _RandomButtonState();
}

final CollectionReference viewHistoryCollection =
    FirebaseFirestore.instance.collection('ViewHistory');

class _RandomButtonState extends State<RandomButton> {
  @override
  Widget build(BuildContext context) {
    CollectionReference food = FirebaseFirestore.instance.collection('Food');

    Future<void> fetchRandomDocument() async {
      try {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection('Food').get();

        int totalDocuments = querySnapshot.docs.length;

        if (totalDocuments > 0) {
          // Generate a random index
          Random random = Random();
          int randomIndex = random.nextInt(totalDocuments);

          // Retrieve the document at the random index
          DocumentSnapshot randomDocument = querySnapshot.docs[randomIndex];

          // Access the document data
          Map<String, dynamic>? data =
              randomDocument.data() as Map<String, dynamic>?;

          if (data != null) {
            // Process the data as needed
            print(data);

            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FoodDetail(
                            documentId: randomDocument.id,
                          ),
                        ),
                      );
                    },
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(60),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                SizedBox(
                                  // width: 200,
                                  // height: 100,
                                  child: Image.network(
                                    data['image'],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${data['calories']} Kcal/ 1 bowl',
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: kButtonColor),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => FoodDetail(
                                              documentId: randomDocument.id,
                                            ),
                                          ),
                                        );
                                        viewHistoryCollection.add({
                                          'uid': 'your_user_id_here',
                                          'foodid': randomDocument.id,
                                          'viewat': DateTime.now().toString(),
                                        });
                                      },
                                      child: const Text('Detail')),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            print('Document data is null');
          }
        } else {
          print('No documents found in the collection');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Container(
      height: 65, // Adjust the height as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Menu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 25), // Adjust the left padding here
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kButtonColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        maximumSize: const Size(780, 50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/mystery-box.png',
                          width: 75,
                          height: 110,
                        ),
                      ),
                      onPressed: () {
                        fetchRandomDocument();
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
