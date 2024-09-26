import 'package:codigo_qr/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  //preguntamos si el Scanner esta completo
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void closeScreen(){
    isScanCompleted = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      //backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                isFlashOn = !isFlashOn;
              });
              controller.toggleTorch();
            }, 
            icon: Icon(
              Icons.flash_on,
              color: isFlashOn
                ?Colors.grey
                :Colors.black,
            )
          ),
          IconButton(
            onPressed: (){
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              controller.switchCamera();
            }, 
            icon: Icon(
              Icons.camera_front,
              color: isFrontCamera 
                ?Colors.grey
                :Colors.black
            )
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black87
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
        )
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded (
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Coloque el QR en el area",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "El escaneo se iniciara automaticamente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children:[ 
                  MobileScanner(
                    controller: controller,
                    onDetect: (barcode) {
                      if(!isScanCompleted){
                        final bar = barcode.barcodes.first;
                        String code = bar.rawValue ?? 'No hay QR';//(barcode.raw).toString() ?? '---';
                        //log("Lo que manda el QR::::> $code");
                        //log("Tipo de dato de barcore:::::>${barcode.runtimeType}");
                        isScanCompleted = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              code: code,
                              closeScreen: closeScreen,
                            )
                          )
                        );
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.black.withOpacity(0.5)//Colors.blueAccent,
                  )
                ]
              )
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Electrolineras",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}