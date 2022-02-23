//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:pdf_flutter/pdf_flutter.dart';
//
//class MyPDFViewer extends StatefulWidget {
//  String networkUrl;
//  bool network;
//  File pdfFile;
//  MyPDFViewer({this.network,this.pdfFile,this.networkUrl});
//
//  @override
//  _MyPDFViewerState createState() => _MyPDFViewerState();
//}
//
//class _MyPDFViewerState extends State<MyPDFViewer> {
//  @override
//  Widget build(BuildContext context) {
//    return  widget.network?
//      Container(child: PDF.network(widget.networkUrl))
//      :Stack(
//        children: [
//          Container(child: PDF.file(widget.pdfFile)),
//        ],
//      );
//
//  }
//}
