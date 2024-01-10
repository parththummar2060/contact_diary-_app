import 'dart:io';

import 'package:contact_diary/pages/variable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'class.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {


  //image picker -- camera & gallery
  File? pickedImage;
  void pickimageopen(imagetype) async {
    final photo = await ImagePicker().pickImage(source: imagetype);
    if (photo == null) {
      return;
    }
    pickedImage = File(photo.path);
    setState(() {
      Navigator.of(context).pop();
    });
  }

  GlobalKey<FormState> addpagekey = GlobalKey<FormState>();

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  String? firstname;
  String? lastname;
  String? phone;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        actions: [
          IconButton(
            onPressed: () {
              if (addpagekey.currentState!.validate()) {
                addpagekey.currentState!.save();
                Contact contact = Contact(
                  firstname: firstname,
                  lastname: lastname,
                  number: phone,
                  email: email,
                  img: pickedImage,
                );
                contactdetail.add(contact);
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Stack(
              alignment: const Alignment(1.2, 1.2),
              children: [
                 CircleAvatar(
                    radius: 50,
                    backgroundImage: (pickedImage != null)?FileImage(pickedImage!) :null,
                    backgroundColor: Colors.grey,
                    child: (pickedImage != null)?null:const Text("Add",
                        style: TextStyle(color: Colors.black, fontSize: 20))),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: imagepicker(),
                            );
                          });
                    });
                  },
                  mini: true,
                  child: const Text(
                    "+",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Form(
                key: addpagekey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("First name",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      TextFormField(
                        controller: firstnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your First name";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          firstname = val;
                        },
                        decoration: InputDecoration(
                            fillColor: (themecolorbool)
                                ? Colors.white
                                : const Color(0xff666666),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Enter your first name",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Last name",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      TextFormField(
                        controller: lastnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your last name";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          lastname = val;
                        },
                        decoration: InputDecoration(
                            fillColor: (themecolorbool)
                                ? Colors.white
                                : const Color(0xff666666),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Enter your last name",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.003,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Phone number",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phonecontroller,
                        validator: (val) {
                          if (val!.length != 10) {
                            return "Please Enter your valid number";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          phone = val;
                        },
                        decoration: InputDecoration(
                            fillColor: (themecolorbool)
                                ? Colors.white
                                : const Color(0xff666666),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Enter your phone number",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.003,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Email",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your email";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          email = val;
                        },
                        decoration: InputDecoration(
                          fillColor: (themecolorbool)
                              ? Colors.white
                              : const Color(0xff666666),
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Enter your email",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget imagepicker() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.height,
          color:(themecolorbool)?Colors.white :Colors.white24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
            ),
            onPressed: () {
              setState(() {
                pickimageopen(ImageSource.camera);
              });
            },
            icon: const Icon(Icons.camera),
            label: const Text("CAMERA"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
            ),
            onPressed: () {
              setState(() {
                pickimageopen(ImageSource.gallery);
              });
            },
            icon: const Icon(Icons.image),
            label: const Text("GALLERY"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.21),
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.close),
            label: const Text("CANCEl"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ],
      ),
    );
  }   
}