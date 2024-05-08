import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:firstparc/Models/CkTitres.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class AfficherLibelle extends StatefulWidget {
String? libelle;
  AfficherLibelle( 
      {Key? key,  this.libelle})
      : super(key: key);

  @override
  AfficherLibelleState createState() => AfficherLibelleState();
}

class AfficherLibelleState extends State<AfficherLibelle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  bool visibile_libelle = false;
  

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CkTitres>(

      asyncItems: (filter) => getData(filter),
      compareFn: (item, sItem) => item.libelle == sItem.libelle,
      onChanged: (value) async {

       widget.libelle = value!.codeT.toString();
       setState(() {
        
       });
   

      },

      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(

          filled: null  ,
          fillColor:  null ,
          border:  OutlineInputBorder() ,
        ),
      ),

      popupProps:  PopupPropsMultiSelection.menu(
        isFilterOnline: true,
        fit: FlexFit.loose,
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: _customPopupItemBuilderExample2,


      ),

    );


  }


}

Widget _customPopupItemBuilderExample2(
    BuildContext context, CkTitres item, bool isSelected) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    child: 
        Text(item.designation,style: TextStyle(color: Colors.black54),),
 
    
  );
}

Future<List<CkTitres>> getData(filter) async {

  

  var url = Uri.parse('http://localhost:5108/api/CkTitres');
  try{
print(url);
    http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // print(response.body);
      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      return data.map((json) => CkTitres.fromJson(json)).toList();
    } else {
      return [];
    }
  }catch(e){
       return [];
  }

}
