import 'package:flutter/material.dart';

class SelectPicker {

  //chose image pic option gallery and camera
  static  showImageBottomSheet({
    required BuildContext context,
    required VoidCallback onCamera,
    required VoidCallback onGallery
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Choose an option",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: onCamera
              ),
              ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                  onTap: onGallery
              ),

            ],
          ),
        );
      },
    );
  }

  // Show image pick options using Dialog (not bottom sheet)
  static showImageDialog({
    required BuildContext context,
    required VoidCallback onCamera,
    required VoidCallback onGallery,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Choose an option",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop(); // close dialog
                  onCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop(); // close dialog
                  onGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

}