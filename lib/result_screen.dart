import 'package:codigo_qr/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {

  final String code;
  final Function() closeScreen;
  const ResultScreen({
    super.key,
    required this.code,
    required this.closeScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            closeScreen();
            Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
          )
        ),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1
          ),          
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //aca veremos el codigo para escaner el QR
              QrImageView(
                data: code,
                size: 150,
                version: QrVersions.auto,
              ),
              const Text(
                "Scanned result",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                )          
              ),
              const SizedBox(height: 10),
              Text(
                code,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  letterSpacing: 1
                ),          
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  onPressed: (){
                    Clipboard.setData(
                      ClipboardData(text: code)
                    );
                  }, 
                  child: const Text(
                    "Copy",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1
                    ),          
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}