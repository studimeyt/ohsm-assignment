import 'dart:io';

import 'package:assignment_flutter/components/my_button.dart';
import 'package:assignment_flutter/components/my_dropdown_menu.dart';
import 'package:assignment_flutter/components/my_textfield.dart';
import 'package:assignment_flutter/components/my_textfield_heading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final propNameController = TextEditingController();

  final emailController = TextEditingController();

  final phNoController = TextEditingController();

  final addressController = TextEditingController();

  final pincodeController = TextEditingController();

  PlatformFile? pickedFile;

  // Sign user out method
  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> selectFile() async {
    // Check if permission is granted
    var status = await Permission.storage.request();

    if (status.isGranted) {
      // Permission granted, proceed with file picking
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          pickedFile = result.files.first;
        });
      }
    } else {
      // Permission denied
      print('User denied the permission to read external storage');
    }
  }

  void confirmSignUserOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Color.fromRGBO(231, 49, 157, 1),fontSize: 16,fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Color.fromRGBO(231, 49, 157, 1),fontSize: 16,fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Handle the confirm action
                signUserOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => confirmSignUserOut(context),
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.green, size: 35.0),
        ),
        title: const Text(
            'Property Setup',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (pickedFile!=null)
                  ElevatedButton(
                    onPressed: selectFile,
                    child: Container(
                      width: 342,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(231, 49, 157, 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,24,16,6),
                            child:Image.file(
                              File(pickedFile!.path!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          ),
                          const Text(
                            'Display Logo',
                            style: TextStyle(color: Color.fromRGBO(231, 49, 157, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),

                ElevatedButton(
                  onPressed: selectFile,
                  child: Container(
                    width: 342,
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(231, 49, 157, 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16,24,16,6),
                          child: Icon(
                            Icons.upload_file_rounded,
                            color: Color.fromRGBO(231, 49, 157, 1),
                            size: 50,
                          ),
                        ),
                        Text(
                          'Display Logo',
                          style: TextStyle(color: Color.fromRGBO(231, 49, 157, 1)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromRGBO(230, 232, 236, 1),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Business information
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'BUSINESS INFORMATION',
                      style: TextStyle(
                        color: Color.fromRGBO(145, 139, 139, 1.0),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
                const SizedBox(height: 10),

                const MyTextFieldHeading(heading: 'Property Type'),
                const SizedBox(height: 10),
                const MyDropDownMenu(option1: 'House', option2: 'Townhouse', option3: 'Unit', option4: 'Villa', hintText: 'Property Type'),
               const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'Property Name'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: propNameController,
                  hintText: 'Property Name',
                  obscureText: false,
                  errorText: "",
                ),
                const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'Phone Number'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: phNoController,
                  hintText: 'Phone Number',
                  obscureText: false,
                  errorText: "",
                ),
                const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'Email Address'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                  errorText: "",
                ),
                const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'Address'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: addressController,
                  hintText: 'Address',
                  obscureText: false,
                  errorText: "",
                ),
                const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'State'),
                const SizedBox(height: 10),

                const MyDropDownMenu(option1: 'Dehradun', option2: 'Delhi', option3: 'Mumbai', option4: 'Tamil Nadu', hintText: 'State'),
                const SizedBox(height: 30),

                const MyTextFieldHeading(heading: 'Pincode'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: pincodeController,
                  hintText: 'e.g. 220011',
                  obscureText: false,
                  errorText: "",
                ),
                const SizedBox(height: 15),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromRGBO(230, 232, 236, 1),
                          )),
                    ],
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                      onTap: () {
                        // Call the function to open the modal sheet
                        ModalSheetHelper().openModalSheet(context);
                      },
                      child: Container(
                        width: 142,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Add Inventory',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

                const SizedBox(height: 15),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(137, 140, 145, 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Complete Setup',
                        style: TextStyle(
                            color: Color.fromRGBO(137, 140, 145, 1), fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ModalSheetHelper {
  final user = FirebaseAuth.instance.currentUser!;
  final propSpaceNameController = TextEditingController();
  final otherPropInventoryTypeController = TextEditingController();
  final capacityController = TextEditingController();
  final amenitiesController = TextEditingController();
  final notesController = TextEditingController();

  void openModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.1,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTextFieldHeading(heading: 'Property Space Name'),
                  const SizedBox(height: 10),
                  MyTextField(
                    errorText: '',
                    valid: true,
                    controller: propSpaceNameController,
                    hintText: 'Property Space Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(heading: 'Property Name'),
                  const SizedBox(height: 10),

                  const MyDropDownMenu(
                    option1: 'Others',
                    option2: 'Under-construction',
                    option3: 'Furnished',
                    option4: 'Unfurnished',
                    hintText: 'Property Inventory Type',
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(
                    heading: 'Other Property Inventory Type',
                  ),
                  const SizedBox(height: 10),

                  MyTextField(
                    valid: true,
                    controller: otherPropInventoryTypeController,
                    hintText: 'Add Property Inventory Type',
                    obscureText: false,
                    errorText: "",
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(heading: 'Capacity'),
                  const SizedBox(height: 10),

                  MyTextField(
                    valid: true,
                    controller: capacityController,
                    hintText: 'Number of Occupants',
                    obscureText: false,
                    errorText: "",
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(heading: 'Amenities'),
                  const SizedBox(height: 10),

                  MyTextField(
                    valid: true,
                    controller: amenitiesController,
                    hintText: 'Available Amenities',
                    obscureText: false,
                    errorText: "",
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(heading: 'Availability Status'),
                  const SizedBox(height: 10),

                  const MyDropDownMenu(
                    option1: 'Active',
                    option2: 'Inactive',
                    option3: 'Removed',
                    option4: 'Others',
                    hintText: 'State',
                  ),
                  const SizedBox(height: 30),

                  const MyTextFieldHeading(heading: 'Notes (if any)'),
                  const SizedBox(height: 10),

                  MyTextField(
                    valid: true,
                    controller: notesController,
                    hintText: 'Add notes if any...',
                    obscureText: false,
                    errorText: "",
                  ),
                  const SizedBox(height: 15),

                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green,
                        )
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const MyButton(onTap: null, btnName: 'Save'),

                  const SizedBox(height: 45),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
