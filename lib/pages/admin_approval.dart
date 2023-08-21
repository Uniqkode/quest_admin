import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Approval'),
      ),
      body: _buildLoanApplicationsList(),
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
