import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/loanreview_model.dart';

class LoanApprovalPage extends StatefulWidget {
  const LoanApprovalPage({super.key});

  @override
  _LoanApprovalPageState createState() => _LoanApprovalPageState();
}

class _LoanApprovalPageState extends State<LoanApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loan Applications'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('loans')
              .where('deliverystatus', isEqualTo: 'preparing')
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
