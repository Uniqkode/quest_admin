import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest_admin/models/loanreview_model.dart';

class PendingLoans extends StatelessWidget {
  const PendingLoans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('loanstatus', isEqualTo: 'pending')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text(
            'Something went wrong!!',
            style: TextStyle(
                letterSpacing: 1.5,
                fontFamily: 'Roboto',
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
              'No Pending Loans',
              style: TextStyle(
                  letterSpacing: 1.5,
                  fontFamily: 'Roboto',
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
    );
  }
}
