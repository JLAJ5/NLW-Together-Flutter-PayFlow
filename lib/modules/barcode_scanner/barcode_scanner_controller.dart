import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'barcode_scanner_status.dart';

class InputImageData {
  final Size size;
  final InputImageRotation imageRotation;
  final InputImageFormat inputImageFormat;
  final List<InputImagePlaneMetadata> planeData;

  InputImageData({
    required this.size,
    required this.imageRotation,
    required this.inputImageFormat,
    required this.planeData,
  });
}

class InputImagePlaneMetadata {
  final int bytesPerRow;
  final int height;
  final int width;

  InputImagePlaneMetadata({
    required this.bytesPerRow,
    required this.height,
    required this.width,
  });
}

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());
  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  var barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  CameraController? cameraController;

  InputImage? imagePicker;

  Future<void> getAvailableCameras() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);

      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.displayValue;
        if (barcode != null) {
          break; // Exit the loop if a non-null barcode is found
        }
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }

      return;
    } catch (e) {
      print("ERRO DA LEITURA $e");
    }
  }

  Future<void> scanWithImagePicker() async {
    final XFile? response = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (response != null) {
      final inputImage = InputImage.fromFilePath(response.path);
      scannerBarCode(inputImage);
    }
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.available();
    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false)
        status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((CameraImage cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final List<Uint8List> bytesList = [];

            for (Plane plane in cameraImage.planes) {
              bytesList.add(plane.bytes);
            }

            final Size imageSize = Size(
              cameraImage.width.toDouble(),
              cameraImage.height.toDouble(),
            );

            final InputImageRotation imageRotation =
                InputImageRotation.rotation0deg;
            final InputImageFormat inputImageFormat = InputImageFormat.nv21;

            final List<InputImagePlaneMetadata> planeData = cameraImage.planes
                .map(
                  (Plane plane) => InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height!,
                    width: plane.width!,
                  ),
                )
                .toList();

            final InputImageMetadata inputImageMetadata = InputImageMetadata(
              size: imageSize,
              rotation: imageRotation,
              format: inputImageFormat,
              bytesPerRow: planeData.first.bytesPerRow,
            );

            final InputImage inputImageCamera = InputImage.fromBytes(
              bytes: bytesList[0], // Assuming you want the first plane
              metadata: inputImageMetadata,
            );

            scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
