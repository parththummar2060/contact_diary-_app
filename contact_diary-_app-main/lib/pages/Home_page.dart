import 'package:contact_diary/pages/class.dart';
import 'package:contact_diary/pages/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      body: (contactdetail.isEmpty)
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/box.png",
                    height: 150,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                  SelectableText(
                    "You have no contacts yet",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: contactdetail.length,
              itemBuilder: (val, i) {
                return contactudf(contactdetail[i]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add_page");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget contactudf(e) {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.of(context).pushNamed("open_page", arguments: e);
        });
      },
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: (e.img != null)
            ? FileImage(e.img!)
            : (themecolorbool)
                ? const AssetImage("images/profile.png")
                : const AssetImage("images/p.png") as ImageProvider,
        backgroundColor: (themecolorbool) ? Colors.white : Colors.grey,
      ),
      title: Text(
        "${e.firstname} ${e.lastname}",
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        "+91 ${e.number}",
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
      trailing: IconButton(
        onPressed: () async {
          await FlutterPhoneDirectCaller.callNumber("+91${e.number}");
        },
        icon: const Icon(
          Icons.call,
          color: Colors.green,
          size: 30,
        ),
      ),
    );
  }
}
