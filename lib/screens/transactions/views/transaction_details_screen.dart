import 'package:flutter/material.dart';
import 'package:springcrate/screens/transactions/class_def/transaction.dart';
import 'package:springcrate/screens/transactions/widgets/assign_form.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transaction});

  final Transaction transaction;

  void _assignEmployee() {
    // TODO: Add logic for assigning employee
  }

  @override
  Widget build(BuildContext context) {
    final transactionDetailItems = [
      [
        _buildDetailWidget(context, 'Plate no.', transaction.plateNo),
        _buildDetailWidget(context, 'Service Type', transaction.service),
        _buildDetailWidget(context, 'Vehicle Type', transaction.vehicleType),
        _buildDetailWidget(context, 'Vehicle Size', transaction.vehicleSize)
      ],
      [
        _buildDetailWidget(context, 'Status', transaction.status),
        _buildDetailWidget(context, 'Start Date', transaction.startDate),
        _buildDetailWidget(context, 'Cost', 'Php ${transaction.cost}'),
        _buildDetailWidget(context, 'Fulfilled', transaction.endDate)
      ]
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions > ${transaction.plateNo}'),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        surfaceTintColor: Colors.grey.shade100,
        child: _buildActionButton(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailWidget(
                    context, 'Transaction ID', transaction.transactionID),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.5),
                  itemCount: transactionDetailItems[0].length,
                  itemBuilder: ((context, index) =>
                      transactionDetailItems[0][index]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 4, thickness: 1, color: Colors.grey),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.5),
                  itemCount: transactionDetailItems[1].length,
                  itemBuilder: ((context, index) =>
                      transactionDetailItems[1][index]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (transaction.employeeID == null) {
      return Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Wrap(children: [AssignForm(context: context)]);
                      });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromHeight(45))),
                child: const Text(
                  'ASSIGN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          const SizedBox(height: 4),
          const Text(
            'Assign the transaction to an employee to start',
            style: TextStyle(fontSize: 12),
          )
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "You're about to complete a transaction.",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "By clicking continue, you verify that the transaction was completed by the employee.",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ]),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                // TODO: Add logic for updating status from on going to completed
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                fixedSize: MaterialStateProperty.all(
                                    const Size.fromHeight(45)),
                              ),
                              child: const Text('CONTINUE')),
                        )
                      ]),
                    );
                  });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                fixedSize:
                    MaterialStateProperty.all(const Size.fromHeight(45))),
            child: const Text(
              'COMPLETE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'This transaction has been assigned to [ADD EMPLOYEE ON INTEG]',
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildDetailWidget(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[800], fontSize: 14),
        )
      ],
    );
  }
}
