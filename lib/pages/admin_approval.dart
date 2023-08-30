import 'package:flutter/material.dart';
import 'package:quest_admin/pages/appproved_loan.dart';
import 'package:quest_admin/pages/pending_loan.dart';
import 'package:quest_admin/pages/rejected_loans.dart';

class LoanApprovalPage extends StatefulWidget {
  const LoanApprovalPage({super.key});

  @override
  _LoanApprovalPageState createState() => _LoanApprovalPageState();
}

class _LoanApprovalPageState extends State<LoanApprovalPage> {
  List<LoanApplication>? _loanApplications;

  @override
  void initState() {
    super.initState();
    _loanApplications = [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: Container(),
          backgroundColor: Colors.white,
          title: const Text('Admin Dashboard'),
          bottom: const TabBar(
            tabs: [
              RepeatedTabs(label: 'Pending'),
              RepeatedTabs(label: 'Approved'),
              RepeatedTabs(label: 'Rejected'),
            ],
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
          ),
        ),
        body: const TabBarView(children: [
          PendingLoans(),
          ApprovedLoans(),
          RejectedLoans(),
        ]),
      ),
    );
  }

  Widget _buildLoanApplicationsList() {
    return ListView.builder(
      itemCount: _loanApplications!.length,
      itemBuilder: (context, index) {
        LoanApplication application = _loanApplications![index];
        return ListTile(
          title: Text(application.borrowerName),
          subtitle: Text('Loan Amount: ${application.loanAmount}'),
          trailing: Text('Status: ${application.status}'),
          onTap: () {
            // Show details of the loan application
          },
        );
      },
    );
  }

  void _approveLoan(LoanApplication application) {
    // Update the loan status to approved
    application.status = 'Approved';
    // Save the changes to the database
    // ...
  }

  void _rejectLoan(LoanApplication application) {
    // Update the loan status to rejected
    application.status = 'Rejected';
    // Save the changes to the database
    // ...
  }
}

class LoanApplication {
  String borrowerName;
  int loanAmount;
  String status;

  LoanApplication(
      {required this.borrowerName,
      required this.loanAmount,
      required this.status});
}

class RepeatedTabs extends StatelessWidget {
  final String label;
  const RepeatedTabs({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
