import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.myUsers});

  final MyUser myUsers;

  @override
  Widget build(BuildContext context) {
    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', myUsers.name),
        _buildDetailWidget(context, 'Employee Rate', myUsers.rate),
        _buildDetailWidget(context, 'Contact Number', myUsers.contactNumber),
      ]
    ];
    return Scaffold(
        appBar: AppBar(title: Text('Employees > ${myUsers.userId}')),
        // bottomNavigationBar: BottomAppBar(
        //   height: 75,
        //   surfaceTintColor: Colors.grey.shade100,
        //   child: _buildActionButton(context),
        // ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3.5),
                      itemCount: employeeDetailItems[0].length,
                      itemBuilder: ((context, index) =>
                          employeeDetailItems[0][index]),
                    ),
                    _buildDetailWidget(context, 'Address', myUsers.address),
                  ],
                )
              ],
            )));
  }
}

// Widget _buildActionButton(BuildContext context) {
//   String actionText = EmployeeUtils.getActionText(employee.status);
//   Color color = EmployeeUtils.getActionColor(employee.status);

//   return ElevatedButton(
//       style: ButtonStyle(
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10))),
//           backgroundColor: MaterialStateProperty.all(color),
//           foregroundColor: MaterialStateProperty.all(Colors.white)),
//       onPressed: () {
//         showModalBottomSheet<dynamic>(
//             context: context,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Wrap(children: [
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "You're about to ${actionText.toLowerCase()} an employee account.",
//                           style: const TextStyle(
//                               color: Colors.orange,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.only(top: 12, bottom: 32),
//                           child: Text(
//                             "By clicking continue, you verify that you want to ${actionText.toLowerCase()} this account.",
//                             style: TextStyle(color: Colors.grey.shade600),
//                           ),
//                         ),
//                       ]),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           // TODO: Add logic for updating status from on going to completed
//                           Navigator.pop(context);
//                         },
//                         style: ButtonStyle(
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10))),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           backgroundColor: MaterialStateProperty.all(color),
//                           fixedSize: MaterialStateProperty.all(
//                               const Size.fromHeight(45)),
//                         ),
//                         child: const Text('CONTINUE')),
//                   )
//                 ]),
//               );
//             });
//       },
//       child: Text(actionText));
// }

Widget _buildDetailWidget(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: TextStyle(color: Colors.grey[800], fontSize: 14),
      )
    ],
  );
}

  // Widget _buildRecenTransactionsCard(
  //     BuildContext context, Transaction transaction) {
  //   return Card(
  //     elevation: 0,
  //     color: const Color(0x00000000),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Plate no: ${transaction.plateNo}',
  //                 style: TextStyle(
  //                     color: Colors.grey[800],
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold)),
  //             Text('Service: ${transaction.service}'),
  //             Text('Commission: Php ${transaction.cost * employee.rate}')
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(transaction.endDate)
  //           ],
  //         ),
  //         Container(
  //           padding: const EdgeInsets.only(top: 16, bottom: 16),
  //           child: const Divider(height: 4, thickness: 1, color: Colors.grey),
  //         )
  //       ],
  //     ),
  //   );
  // }

