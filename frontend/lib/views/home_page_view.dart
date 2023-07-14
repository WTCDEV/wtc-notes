import 'package:flutter/material.dart';
import 'package:frontend/shared/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? email;
  int? idUser;

  Future<void> readSharedPrefs() async {
    final String? usernamePref = await SharedPrefUtils.readUsername();

    final int? IdUserPref = await SharedPrefUtils.readIdUser();
    setState(() {
      username = usernamePref;

      idUser = IdUserPref;
    });
  }

  @override
  Widget build(BuildContext context) {
    readSharedPrefs();
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                title: Text(
                  'Hi $username!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),

                trailing: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/iconbocchi.jpg'),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 40,
              mainAxisSpacing: 30,
              shrinkWrap: true,
              children: [
                ItemDashboard(
                  title: 'My Notes',
                  iconData: Icons.note,
                  background: Colors.blue,
                  route: '/notes',
                ),
                ItemDashboard(
                  title: 'Add Note',
                  iconData: Icons.note_add,
                  background: Colors.blue,
                  route: '/add-note',
                ),
                ItemDashboard(
                  title: 'Trash Notes',
                  iconData: Icons.delete,
                  background: Colors.blue,
                  route: '/trash',
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  icon: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 24.0,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ItemDashboard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color background;
  final String route;

  const ItemDashboard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.background,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: background, shape: BoxShape.circle),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
