import 'package:flutter/material.dart';

class Customerdetailedscreen extends StatefulWidget {
  final Map<String, dynamic> customer;
  const Customerdetailedscreen({super.key, required this.customer});

  @override
  State<Customerdetailedscreen> createState() => _CustomerdetailedscreenState();
}

class _CustomerdetailedscreenState extends State<Customerdetailedscreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back,color: Colors.white,),
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF667eea),
                  Color(0xFF764ba2),
                ],
              ),
            ),
          ),
          title: const Text('Customer Details',style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: widget.customer['ImagePath'] != null &&
                    widget.customer['ImagePath'].toString().isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://www.pqstec.com/InvoiceApps${widget.customer['ImagePath']}',
                    width: width * 0.5,
                    height: width * 0.5,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
      
      
              _buildDetailRow("Name", widget.customer['Name']),
              const Divider(),
      
      
              _buildDetailRow("Phone", widget.customer['Phone']),
              const Divider(),
      
      
              _buildDetailRow("Email", widget.customer['Email']),
              const Divider(),
      
              _buildDetailRow("Address", widget.customer['PrimaryAddress']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
