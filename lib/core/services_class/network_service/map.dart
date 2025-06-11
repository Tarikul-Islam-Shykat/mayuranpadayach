// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../const/app_colors.dart';
import '../../global_widegts/loading_screen.dart';
import '../../style/global_text_style.dart';

class LocationResult {
  final double latitude;
  final double longitude;
  final String? locationName;

  LocationResult({
    required this.latitude,
    required this.longitude,
    this.locationName,
  });
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('selectLocation'.tr)),
      body: const MapSelection(),
    );
  }
}

class MapSelection extends StatefulWidget {
  const MapSelection({super.key});

  @override
  _MapSelectionState createState() => _MapSelectionState();
}

class _MapSelectionState extends State<MapSelection> {
  LatLng _selectedLocation = const LatLng(23.8103, 90.4125); // Default location
  GoogleMapController? _mapController;
  bool _isLoading = true;
  String? _locationName;
  bool _isGettingLocationName = false;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Step 1: Check if location services are enabled
  Future<void> _checkLocationPermission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // First check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _permissionDenied = true;
          _isLoading = false;
        });
        return;
      }

      // Then check for location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _permissionDenied = true;
            _isLoading = false;
          });
          return;
        }
      }

      // Handle permanently denied permissions
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _permissionDenied = true;
          _isLoading = false;
        });
        return;
      }

      // If we get here, permissions are granted, so get the location
      _initializeCurrentLocation();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _permissionDenied = true;
      });
      if (kDebugMode) {
        print('Permission check error: $e');
      }
    }
  }

  // Step 2: Get current location once permission is granted
  Future<void> _initializeCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // Get location name for the initial position
      _getLocationName(_selectedLocation);

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _selectedLocation, zoom: 14.0),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      EasyLoading.showError('Error getting current location'.tr);
      if (kDebugMode) {
        print('Location initialization error: $e');
      }
    }
  }

  // Get location name from coordinates
  Future<void> _getLocationName(LatLng position) async {
    if (_isGettingLocationName) return;

    setState(() {
      _isGettingLocationName = true;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String name = '';

        if (place.name != null && place.name!.isNotEmpty) {
          name += place.name!;
        }

        if (place.street != null && place.street!.isNotEmpty) {
          if (name.isNotEmpty) name += ', ';
          name += place.street!;
        }

        if (place.locality != null && place.locality!.isNotEmpty) {
          if (name.isNotEmpty) name += ', ';
          name += place.locality!;
        }

        if (name.isEmpty && place.administrativeArea != null) {
          name = place.administrativeArea!;
        }

        setState(() {
          _locationName = name;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location name: $e');
      }
      setState(() {
        _locationName = null;
      });
    } finally {
      setState(() {
        _isGettingLocationName = false;
      });
    }
  }

  // Open app settings to enable location permission
  Future<void> _openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  // Open location settings
  Future<void> _openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // Permission denied UI
  Widget _buildPermissionDeniedUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_disabled,
              size: 70,
              color: AppColors.primaryColor.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Location access required'.tr,
              style: globalTextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'This app needs access to your location to show maps and find places near you.'
                  .tr,
              style: globalTextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              onPressed: _openAppSettings,
              child: Text(
                'Open App Settings'.tr,
                style: globalTextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _openLocationSettings,
              child: Text(
                'Open Location Settings'.tr,
                style: globalTextStyle(color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _checkLocationPermission,
              child: Text(
                'Try Again'.tr,
                style: globalTextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: btnLoading());
    }

    if (_permissionDenied) {
      return _buildPermissionDeniedUI();
    }

    return Stack(
      children: [
        GoogleMap(
          scrollGesturesEnabled: true, // Allows panning
          zoomGesturesEnabled: true, // Allows pinch zoom
          rotateGesturesEnabled: true, // Allows rotation
          tiltGesturesEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _selectedLocation,
            zoom: 14.0,
          ),

          onMapCreated: (controller) {
            _mapController = controller;
            _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: _selectedLocation, zoom: 14.0),
              ),
            );
          },
          onTap: (LatLng position) {
            if (kDebugMode) {
              print(
                "Map tapped at: ${position.latitude}, ${position.longitude}",
              );
            }
            setState(() {
              _selectedLocation = position;
            });
            _getLocationName(position);
          },

          // onTap: (LatLng position) {
          //   setState(() {
          //     _selectedLocation = position;
          //   });
          //   _getLocationName(position);
          // },
          markers: {
            Marker(
              markerId: const MarkerId('selectedLocation'),
              position: _selectedLocation,
              infoWindow: InfoWindow(
                title: _locationName ?? 'Selected Location',
                snippet:
                    'Lat: ${_selectedLocation.latitude.toStringAsFixed(6)}, '
                    'Long: ${_selectedLocation.longitude.toStringAsFixed(6)}',
              ),
            ),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          zoomControlsEnabled: true,
        ),
        // Location info card
        if (_locationName != null)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _locationName!,
                      style: globalTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lat: ${_selectedLocation.latitude.toStringAsFixed(6)}\n'
                      'Long: ${_selectedLocation.longitude.toStringAsFixed(6)}',
                      style: globalTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // Loading indicator for location name
        if (_isGettingLocationName)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        // Selection button
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                final result = LocationResult(
                  latitude: _selectedLocation.latitude,
                  longitude: _selectedLocation.longitude,
                  locationName: _locationName,
                );

                // Print the result for debugging
                if (kDebugMode) {
                  print('Selected Location:');
                  print('Latitude: ${result.latitude}');
                  print('Longitude: ${result.longitude}');
                  print(
                    'Location Name: ${result.locationName ?? "Not available"}',
                  );
                }

                // Return te result to the previous screen
                Get.back(result: result);
              },
              child: Text(
                'confirmLocation'.tr,
                style: globalTextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// import 'package:eliecamuss/core/const/app_colors.dart';
// import 'package:eliecamuss/core/style/global_text_style.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatelessWidget {
//   MapPage({super.key});
//   // final TrasureController controller = Get.find<TrasureController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('selectLocation'.tr)),
//       body: MapSelection(),
//     );
//   }
// }

// class MapSelection extends StatefulWidget {
//   // final TrasureController controller;

//   const MapSelection({super.key});

//   @override
//   _MapSelectionState createState() => _MapSelectionState();
// }

// class _MapSelectionState extends State<MapSelection> {
//   LatLng _selectedLocation = const LatLng(23.8103, 90.4125);
//   GoogleMapController? _mapController;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCurrentLocation();
//   }

//   Future<void> _initializeCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         _selectedLocation = LatLng(position.latitude, position.longitude);
//         _isLoading = false;
//       });

//       if (_mapController != null) {
//         _mapController!.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(target: _selectedLocation, zoom: 14.0),
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       EasyLoading.showError('please_enable_location_permission'.tr);
//       if (kDebugMode) {
//         print('//////////////////////{$e}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _selectedLocation,
//                 zoom: 14.0,
//               ),
//               onMapCreated: (controller) {
//                 _mapController = controller;

//                 _mapController!.animateCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(target: _selectedLocation, zoom: 14.0),
//                   ),
//                 );
//               },
//               onTap: (LatLng position) {
//                 setState(() {
//                   _selectedLocation = position;
//                 });
//               },
//               markers: {
//                 Marker(
//                   markerId: MarkerId('selectedLocation'.tr),
//                   position: _selectedLocation,
//                 ),
//               },
//             ),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                   onPressed: () {
//                     // widget.controller.setLatLong(
//                     //   _selectedLocation.latitude,
//                     //   _selectedLocation.longitude,
//                     // );
//                     // Get.back();
//                   },
//                   child: Text(
//                     'selectLocationOnMap'.tr,
//                     style: globalTextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//   }
// }
