// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';

// class CustomCameraScreen extends StatefulWidget {
//   final bool isPortraitMode;

//   const CustomCameraScreen({super.key, this.isPortraitMode = false});

//   @override
//   State<CustomCameraScreen> createState() => _CustomCameraScreenState();
// }

// class _CustomCameraScreenState extends State<CustomCameraScreen> {
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   bool _isInitialized = false;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     debugPrint(
//       'CustomCamera initialized with portrait mode: ${widget.isPortraitMode}',
//     );
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       // Request camera permission
//       final status = await Permission.camera.request();

//       if (status.isDenied || status.isPermanentlyDenied) {
//         setState(() {
//           _error = 'Camera permission denied';
//         });
//         return;
//       }

//       // Set orientation based on toggle
//       if (widget.isPortraitMode) {
//         debugPrint('Setting PORTRAIT orientation');
//         await SystemChrome.setPreferredOrientations([
//           DeviceOrientation.portraitUp,
//         ]);
//       } else {
//         debugPrint('Setting LANDSCAPE orientation');
//         await SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight,
//         ]);
//       }

//       // Small delay for orientation to apply
//       await Future.delayed(const Duration(milliseconds: 300));

//       // Get available cameras
//       _cameras = await availableCameras();

//       if (_cameras == null || _cameras!.isEmpty) {
//         setState(() {
//           _error = 'No camera available';
//         });
//         return;
//       }

//       // Initialize camera controller
//       _controller = CameraController(
//         _cameras![0],
//         ResolutionPreset.high,
//         enableAudio: false,
//         imageFormatGroup: ImageFormatGroup.jpeg,
//       );

//       await _controller!.initialize();

//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = 'Error initializing camera: $e';
//       });
//       debugPrint('Camera initialization error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     // Reset orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }

//   Future<void> _takePicture() async {
//     if (_controller != null && _controller!.value.isInitialized) {
//       try {
//         final XFile image = await _controller!.takePicture();
//         if (mounted) {
//           Navigator.pop(context, File(image.path));
//         }
//       } catch (e) {
//         debugPrint('Error taking picture: $e');
//         if (mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Error taking picture: $e')));
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_error != null) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error_outline, color: Colors.white, size: 48),
//               const SizedBox(height: 16),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   _error!,
//                   style: const TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Go Back'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     if (!_isInitialized || _controller == null) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: CircularProgressIndicator(color: Colors.white)),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Camera Preview
//           Center(child: CameraPreview(_controller!)),

//           // Orientation indicator (for debugging)
//           Positioned(
//             top: 40,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 widget.isPortraitMode ? 'Portrait Mode' : 'Landscape Mode',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),

//           // Controls
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Cancel Button
//                 IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.close, color: Colors.white, size: 32),
//                 ),

//                 const SizedBox(width: 50),

//                 // Capture Button
//                 GestureDetector(
//                   onTap: _takePicture,
//                   child: Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.grey, width: 4),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
