import 'package:contact_diary/pages/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'class.dart';

class OneContactOpen extends StatefulWidget {
  const OneContactOpen({Key? key}) : super(key: key);

  @override
  _OneContactOpenState createState() => _OneContactOpenState();
}

class _OneContactOpenState extends State<OneContactOpen> {
  @override
  Widget build(BuildContext context) {
    dynamic e = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                themecolorbool = !themecolorbool;
              });
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor:
                  (themecolorbool) ? Colors.black12 : Colors.white54,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (e.img != null)
                      ? FileImage(e.img!)
                      : (themecolorbool)
                          ? const AssetImage("images/profile.png")
                          : const AssetImage(
                              "images/p.png",
                            ) as ImageProvider,
                  backgroundColor: (themecolorbool) ? Colors.grey : Colors.grey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "${e.firstname} ${e.lastname}",
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                Text(
                  "+91 ${e.number}",
                  style: TextStyle(
                      fontSize: 19,
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/", (route) => false);
                      contactdetail.remove(e);
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context)
                            .pushNamed("edit_page", arguments: e);
                      });
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              height: 1,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: IconButton(
                    onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(
                          "+91${e.number}");
                    },
                    icon: Icon(Icons.call,
                        color:
                            Theme.of(context).textTheme.displayMedium!.color),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xffE9AC13),
                  child: IconButton(
                    onPressed: () async {
                      final uri = 'sms:${e.number}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      }
                    },
                    icon: Icon(Icons.message,
                        color:
                            Theme.of(context).textTheme.displayMedium!.color),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xff01C0DA),
                  child: IconButton(
                    onPressed: () async {
                      final uri = 'mailto:${e.email}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      }
                    },
                    icon: Icon(Icons.mail,
                        color:
                            Theme.of(context).textTheme.displayMedium!.color),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xffDA8300),
                  child: IconButton(
                    onPressed: () {
                      Share.share(
                          "${e.firstname} ${e.lastname} \n ${e.number} ");
                    },
                    icon: Icon(Icons.share,
                        color:
                            Theme.of(context).textTheme.displayMedium!.color),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Divider(
              height: 1,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ],
        ),
      ),
    );
  }
}

/*
i am maiyani jenil kishorbhai.
i am maiyani jenil kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.
i am jenil maiyani kishorbhai.+




*/
