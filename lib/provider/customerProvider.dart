import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CustomerProvider with ChangeNotifier {
  bool isLoading = false;
  int currentPage = 1;
  List<dynamic> customers = [];

  Future<void> fetchCustomers(String token, int page) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await Dio().get(
        'https://www.pqstec.com/InvoiceApps/Values/GetCustomerList?searchquery&pageNo=$page&pageSize=20&SortyBy=Balance',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      customers = response.data['CustomerList'];
      currentPage = page;
    } catch (e) {
      print('Error fetching customers: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
