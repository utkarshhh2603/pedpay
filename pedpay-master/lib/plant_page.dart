import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart'; 
import 'package:geolocator/geolocator.dart';
import 'theme.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  CameraController? _controller;
  List<XFile?> _capturedImages = [null, null, null];
  List<String> _locationData = ["", "", ""];
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureGeotaggedImage(int index) async {
    if (!_isCameraInitialized || _controller == null) return;

    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final XFile photo = await _controller!.takePicture();

      setState(() {
        _capturedImages[index] = photo;
        _locationData[index] =
            "Lat: ${position.latitude.toStringAsFixed(4)}, Log: ${position.longitude.toStringAsFixed(4)}";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo captured with live feed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Capture Error: $e')),
      );
    }
  }

  void _uploadPlantation() async {
    if (_capturedImages.every((img) => img == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture at least one photo.')),
      );
      return;
    }
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VerificationOverlay(), // Calling the class below
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Plantation Report'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.house, color: AppColors.darkerGreen),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Use the live preview boxes below to capture photos.'),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _LiveCameraBox(
                    isInitialized: _isCameraInitialized,
                    controller: _controller,
                    capturedImage: _capturedImages[index],
                    locationInfo: _locationData[index],
                    onTap: () => _captureGeotaggedImage(index),
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _uploadPlantation,
                icon: const Icon(FontAwesomeIcons.cloudArrowUp),
                label: const Text('UPLOAD PLANTATION'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveCameraBox extends StatelessWidget {
  final bool isInitialized;
  final CameraController? controller;
  final XFile? capturedImage;
  final String locationInfo;
  final VoidCallback onTap;

  const _LiveCameraBox({
    required this.isInitialized,
    this.controller,
    this.capturedImage,
    required this.locationInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: capturedImage != null ? Colors.green : AppColors.primaryGreen,
            width: 2,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (isInitialized && controller != null && capturedImage == null)
              CameraPreview(controller!)
            else if (capturedImage != null)
              const Center(child: Icon(Icons.check_circle, color: Colors.green, size: 40))
            else
              const Center(child: CircularProgressIndicator()),
            
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Text(
                capturedImage != null ? locationInfo : "Tap to Capture",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 9, color: Colors.white, backgroundColor: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- ADDED THE MISSING VERIFICATION CLASS BELOW ---

class VerificationOverlay extends StatefulWidget {
  @override
  State<VerificationOverlay> createState() => _VerificationOverlayState();
}

class _VerificationOverlayState extends State<VerificationOverlay> {
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    // Simulate the 3-second verification delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isSuccess = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.95),
      child: Center(
        child: _isSuccess ? _buildSuccess(context) : _buildLoading(),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Verifying Plantation...', 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
        const SizedBox(height: 20),
        const CircularProgressIndicator(color: AppColors.primaryGreen),
        const SizedBox(height: 20),
        const Text('Confirming coordinates on blockchain...'),
      ],
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, size: 60, color: Colors.green),
        const SizedBox(height: 20),
        const Text('Successfully Recorded!', 
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Go back home
          },
          child: const Text('RETURN TO HOME'),
        ),
      ],
    );
  }
}