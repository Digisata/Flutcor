import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _detailPage = ModalRoute.of(context).settings.arguments;
    
    return Center(
      child: Text(_detailPage.toString())
    );
  }
}