import 'dart:io';

class Contact
{
  String? firstname;
  String? lastname;
  String? number;
  String? email;
  File? img;

  Contact({
    required this.firstname,
    required this.lastname,
    required this.number,
    required this.email,
    required this.img,
});
}

List <Contact> contactdetail = <Contact> [];