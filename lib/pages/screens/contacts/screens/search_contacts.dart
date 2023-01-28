import 'dart:convert';

import 'package:e_wallet_mobile_app/models/requests.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SearchData extends SearchDelegate{
  List<RequestsModel> requests =[];
  Future<List<RequestsModel>> getcustomrRequests({String ?query}) async {
    var data = [];
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/customer/get-contacts?type=2"));
    print(response.body.toString());
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      requests= data.map((e) => RequestsModel.fromJson(e)).toList();
      if(query !=null ){
        requests =requests.where((element) => element.fName!.toLowerCase().contains(query.toLowerCase())).toList();
      }
    }
    else{
      print("errpr ");
    }
    return requests;

  }



  @override
  List<Widget>? buildActions(BuildContext context) {
    return[ IconButton(onPressed: (){},icon: Icon(Icons.close),)];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    },icon: Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    return    FutureBuilder(
      future: getcustomrRequests(),
      builder: (context ,snapshot){
        var data = snapshot.data;
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:requests.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 15);
            },
            itemBuilder: (BuildContext context, int index) {
              return BuildContactItem(requests: requests[index]);
            },
          );
        }
      },

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search for customer"));
  }

}
