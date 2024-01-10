import 'dart:io';
import 'package:contact_diary/pages/variable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'class.dart';

class EditContactOpen extends StatefulWidget {
  const EditContactOpen({Key? key}) : super(key: key);

  @override
  State<EditContactOpen> createState() => _EditContactOpenState();
}

class _EditContactOpenState extends State<EditContactOpen> {


  //image picker -- camera & gallery
  File? pickimages;
  void pickimageopen(imagetype) async {
    final photo = await ImagePicker().pickImage(source: imagetype);
    if (photo == null) {
      return;
    }
    pickimages = File(photo.path);
    setState(() {
      Navigator.of(context).pop();
    });
  }

  GlobalKey<FormState> addpagekey = GlobalKey<FormState>();

  TextEditingController editfirstnamecontroller = TextEditingController();
  TextEditingController editlastnamecontroller = TextEditingController();
  TextEditingController editphonecontroller = TextEditingController();
  TextEditingController editemailcontroller = TextEditingController();

  String? efirstname;
  String? elastname;
  String? ephone;
  String? eemail;
  bool confirmedit = false;

  @override
  Widget build(BuildContext context) {
    dynamic m = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          setState(() {
            if(confirmedit)
              {
                Navigator.of(context).pop();
              }
          });
        }, icon: const Icon(Icons.arrow_back_rounded),),
        title: const Text("Edit"),
        actions: [
          IconButton(
            onPressed: () {
              if(confirmedit)
                {
                  if (addpagekey.currentState!.validate()) {
                    addpagekey.currentState!.save();
                    Contact contact = Contact(
                      firstname: efirstname,
                      lastname: elastname,
                      number: ephone,
                      email: eemail,
                      img: pickimages,
                    );
                    contactdetail.remove(m);
                    contactdetail.add(contact);
                    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                  }
                }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body:  (confirmedit)?SingleChildScrollView(
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
                    backgroundImage:(pickimages == null)?(m.img == null )?(themecolorbool)?const AssetImage("images/profile.png"):const AssetImage("images/darkprofile.png"):FileImage(m.img) as ImageProvider :FileImage(pickimages!),
                    backgroundColor: Colors.grey,
                ),
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
                        controller: editfirstnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your First name";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          efirstname = val;
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
                        controller: editlastnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your last name";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          elastname = val;
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
                        controller: editphonecontroller,
                        validator: (val) {
                          if (val!.length != 10) {
                            return "Please Enter your valid number";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          ephone = val;
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
                        controller: editemailcontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter your email";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          eemail = val;
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
      )
          : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                      const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Text("Add",
                              style: TextStyle(color: Colors.black, fontSize: 20))),
                      FloatingActionButton(
                        onPressed: ()  {
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
                              enabled: false,
                              controller: editfirstnamecontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please Enter your First name";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                efirstname = val;
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
                              enabled: false,
                              controller: editlastnamecontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please Enter your last name";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                elastname = val;
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
                              enabled: false,
                              keyboardType: TextInputType.number,
                              controller: editphonecontroller,
                              validator: (val) {
                                if (val!.length != 10) {
                                  return "Please Enter your valid number";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                ephone = val;
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
                              enabled: false,
                              controller: editemailcontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please Enter your email";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                eemail = val;
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
            AlertDialog(
              title: const Text("Are you sure to change your detail"),
              actions: [
                TextButton(
                  onPressed:(){
                      confirmedit = true;
                    setState(() {
                      editfirstnamecontroller.text  = m.firstname;
                      editlastnamecontroller.text = m.lastname;
                      editphonecontroller.text = m.number;
                      editemailcontroller.text = m.email;
                    });
                  },
                  child: const Text("Yes"),),
                TextButton(
                  onPressed:(){
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text("No"),),
              ],
            ),
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
