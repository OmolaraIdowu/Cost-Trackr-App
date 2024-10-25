import 'dart:io';

import 'package:cost_trackr/screens/auth/login.dart';
import 'package:cost_trackr/screens/notification.dart';
import 'package:cost_trackr/screens/settings.dart';
import 'package:cost_trackr/services/auth_service.dart';
import 'package:cost_trackr/services/firestore_service.dart';
import 'package:cost_trackr/services/storage_service.dart';
import 'package:cost_trackr/utils/snackbar.dart';
import 'package:cost_trackr/widgets/button_icon_bg.dart';
import 'package:cost_trackr/widgets/dialog.dart';
import 'package:cost_trackr/widgets/image_picker.dart';
import 'package:cost_trackr/widgets/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService();
  File? profileImage;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void logout() {
      CustomDialog.show(
          context: context,
          title: 'Log Out',
          content: 'Are you sure you want to logout?',
          confirmText: 'Yes',
          onConfirm: () async {
            // Show a loading dialog while logging out
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                ),
              ),
            );

            // Perform the sign out
            final AuthResult result = await AuthService().signOut();

            Navigator.of(context).pop(); // Dismiss the loading dialog

            if (result.isSuccess) {
              // Successful login
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const LoginScreen()),
              );
            } else {
              // Error occurred
              context.showSnackBar(result.errorMessage!);
            }
            Navigator.of(context).pop(); // Dismiss the loading dialog
          });
    }

    // void logout() {
    //   CustomDialog.show(
    //     context: context,
    //     title: 'Log Out',
    //     content: 'Are you sure you want to logout?',
    //     confirmText: 'Yes',
    //     onConfirm: () async {
    //       // Set _isUploading to true to show the loading indicator
    //       setState(() {
    //         _isAuthenticating = true;
    //       });
    //
    //       // Perform the sign out
    //       final AuthResult result = await AuthService().signOut();
    //
    //       if (result.isSuccess) {
    //         // Successful logout
    //         Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (ctx) => const LoginScreen()),
    //         );
    //       } else {
    //         // Error occurred
    //         context.showSnackBar(result.errorMessage!);
    //       }
    //       setState(() {
    //         _isAuthenticating = false;
    //       });
    //     },
    //   );
    // }

    void uploadImage(String uid, File imageFile) async {
      if (profileImage == null) return;

      setState(() {
        _isUploading = true;
      });

      try {
        // Upload the image to Firebase Storage
        final imageUrl = await _storageService.uploadUserImage(uid, imageFile);

        final userData = await FirestoreService().getUserData(uid);
        if (userData == null) {
          context.showSnackBar('User data not found');
          return;
        }
        // Update user data with the image URL
        final updatedUserData = userData.copyWith(imageUrl: imageUrl);
        await FirestoreService().saveUserData(updatedUserData);

        context.showSnackBar('Profile photo uploaded successfully.');
      } catch (error) {
        context.showSnackBar('An unexpected error occurred: $error');
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }

    void pickImage(ImageSource source) async {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      File selectedImage = File(pickedImage.path);

      setState(() {
        profileImage = selectedImage;
        _isUploading = true;
      });

      uploadImage(FirebaseAuth.instance.currentUser!.uid, selectedImage);
    }

    void showBottomSheet() {
      if (Platform.isIOS) {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) {
            return CupertinoActionSheet(
              title: Text(
                profileImage != null ? 'Edit Photo' : 'Add Photo',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    pickImage(ImageSource.gallery);
                  },
                  child: Text(
                    'Choose from Gallery',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    pickImage(ImageSource.camera);
                  },
                  child: Text(
                    'Camera',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (profileImage != null)
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      // view photo logic here
                    },
                    child: Text(
                      'View Photo',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    CustomDialog.show(
                      context: context,
                      title: 'Delete Photo',
                      content: 'Are you sure you want to delete this picture?',
                      confirmText: 'Delete',
                      onConfirm: () {
                        Navigator.of(ctx).pop();
                        setState(() {
                          profileImage = null;
                        });
                        context.showSnackBar('Photo deleted successfully.');
                      },
                    );
                  },
                  isDestructiveAction: true,
                  child: Text('Delete Photo',
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                isDefaultAction: true,
                child: const Text('Cancel'),
              ),
            );
          },
        );
      } else {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        profileImage != null ? 'Edit Photo' : 'Add Photo',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (profileImage != null)
                        CustomIconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/delete.svg',
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColorDark,
                                BlendMode.srcIn),
                          ),
                          onPressed: () {
                            CustomDialog.show(
                              context: context,
                              title: 'Delete Photo',
                              content:
                                  'Are you sure you want to delete this picture?',
                              confirmText: 'Delete',
                              onConfirm: () {
                                setState(() {
                                  profileImage = null;
                                });
                                context.showSnackBar(
                                    'Photo deleted successfully.');
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                MenuItem(
                  icon: Icons.insert_photo_outlined,
                  title: 'Choose from Gallery',
                  style: Theme.of(context).textTheme.titleSmall,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    pickImage(ImageSource.gallery);
                  },
                ),
                MenuItem(
                  icon: Icons.camera_alt_outlined,
                  title: 'Camera',
                  style: Theme.of(context).textTheme.titleSmall,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    pickImage(ImageSource.camera);
                  },
                ),
                if (profileImage != null) ...[
                  MenuItem(
                    icon: Icons.preview_outlined,
                    title: 'View Photo',
                    style: Theme.of(context).textTheme.titleSmall,
                    onTap: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Stack(children: [
              Container(
                height: 100,
                width: double.infinity,
                color: theme.primaryColor,
              ),
              GestureDetector(
                onTap: showBottomSheet,
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  child: UserImagePicker(
                    imageFile: profileImage,
                    isUploading: _isUploading,
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 16),
            // User Info Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Maya Stark', style: theme.textTheme.headlineMedium),
                CustomIconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      colorFilter: ColorFilter.mode(
                          theme.primaryColorDark, BlendMode.srcIn),
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {}),
              ],
            ),
            Text(
              'mayastark45@gmail.com',
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: 30),
            // Menu Options
            Expanded(
              child: ListView(
                children: [
                  MenuItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Account Info',
                    onTap: () {},
                  ),
                  MenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                  MenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  MenuItem(
                    icon: Icons.info_outline_rounded,
                    title: 'Version Details',
                    onTap: () {},
                  ),
                  MenuItem(
                    icon: Icons.logout_outlined,
                    title: 'Log Out',
                    onTap: logout,
                  ),
                ],
              ),
            ),
            // Footer
            Text(
              'Cost Trackr Version 1.0.0',
              style: theme.textTheme.titleMedium!
                  .copyWith(color: Colors.grey, fontSize: 10),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// // Fetch current user data from Firestore
// final userDoc =
//     await FirebaseFirestore.instance.collection('users').doc(uid).get();
//
// if (!userDoc.exists) {
// throw Exception('User does not exist');
// }
//
// // Retrieve user data
// final userData = userDoc.data()!;
// final email = userData['email'] as String;
// final name = userData['name'] as String;
