// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../shared/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 22,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 24,
                  offset: Offset(0, 11),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/avatar');
                  },
                  child: FutureBuilder(
                    future: SharedPrefUtils.readNameImage(),
                    builder: (context, snapshot) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: snapshot.data == null
                                ? const AssetImage('assets/image-1.png')
                                : AssetImage(
                                    'assets/${snapshot.data}.png',
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                  future: SharedPrefUtils.readUsername(),
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    );
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                  future: SharedPrefUtils.readEmail(),
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600));
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
