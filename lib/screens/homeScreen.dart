import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gtr/screens/customerDetailedScreen.dart';
import 'package:gtr/provider/customerProvider.dart';
import 'package:gtr/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginScreen.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}


class _HomescreenState extends State<Homescreen> {
 dynamic data;
 bool isLoading=false;
  List<dynamic> customers=[];


  void logout() {
    Provider.of<Userprovider>(context,listen: false).setToken('');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
    );
  }
 Future<void> initializeData() async {
   final userProvider = Provider.of<Userprovider>(context, listen: false);
   final token = await userProvider.checkToken();
   await Provider.of<CustomerProvider>(context, listen: false).fetchCustomers(token, 1);
 }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

      super.initState();
     initializeData();
    }

 @override
 Widget build(BuildContext context) {
   final customerProvider = Provider.of<CustomerProvider>(context);
   final userProvider = Provider.of<Userprovider>(context, listen: false);

   return SafeArea(
     child: Scaffold(
       appBar: AppBar(
         flexibleSpace: Container(
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
             ),
           ),
         ),
         title: const Text("Customers", style: TextStyle(color: Colors.white)),
         centerTitle: true,
         actions: [
           Padding(
             padding: const EdgeInsets.only(right: 8.0),
             child: InkWell(
               onTap: () {
                 logout();
               },
               child: const Icon(Icons.logout, color: Colors.white),
             ),
           )
         ],
       ),
       body: customerProvider.isLoading
           ? const Center(child: CircularProgressIndicator())
           : Column(
         children: [
           Expanded(
             child: ListView.builder(
               itemCount: customerProvider.customers.length,
               itemBuilder: (context, index) {
                 final customer = customerProvider.customers[index];
                 return ListTile(
                   onTap: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => Customerdetailedscreen(customer: customer),
                       ),
                     );
                   },
                   leading: customer['ImagePath'] != null
                       ? CircleAvatar(
                     radius: 25,
                     backgroundImage: NetworkImage(
                       'https://www.pqstec.com/InvoiceApps${customer['ImagePath']}',
                     ),
                     backgroundColor: Colors.grey,
                   )
                       : const Icon(Icons.account_circle_rounded, size: 40),
                   title: Text(customer['Name']),
                   subtitle: Text(customer['Email'] ?? "N/A"),
                 );
               },
             ),
           ),
           Container(
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
                 colors: [Color(0xFF667eea), Color(0xFF764ba2)],
               ),
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   if (customerProvider.currentPage > 1)
                     ElevatedButton(
                       onPressed: () async {
                         final token = await userProvider.checkToken();
                         customerProvider.fetchCustomers(token, customerProvider.currentPage - 1);
                       },
                       child: const Text("Prev"),
                     ),
                   Text(
                     "Page - ${customerProvider.currentPage}/18",
                     style: const TextStyle(color: Colors.white),
                   ),
                   if (customerProvider.currentPage < 18)
                     ElevatedButton(
                       onPressed: () async {
                         final token = await userProvider.checkToken();
                         customerProvider.fetchCustomers(token,customerProvider.currentPage + 1);
                       },
                       child: const Text("Next"),
                     ),
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }

}
