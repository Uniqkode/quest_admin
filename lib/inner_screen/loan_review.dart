import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/loanreview_model.dart';

class LoanReviewPage extends StatefulWidget {
  const LoanReviewPage({super.key});

  @override
  _LoanReviewPageState createState() => _LoanReviewPageState();
}

class _LoanReviewPageState extends State<LoanReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loan Applications'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('loans')
              .where('loanstatus', isEqualTo: 'pending')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'Something went wrong!!',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontFamily: 'Acme',
                    color: Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.purpleAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.purple,
                  ),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No Active loans',
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontFamily: 'Acme',
                      color: Colors.blueGrey,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return LoanReviewModel(loans: snapshot.data!.docs[index]);
                });
          },
        ));
  }
}
