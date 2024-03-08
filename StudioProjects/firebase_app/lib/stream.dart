import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class HomeData extends StatefulWidget {
  const HomeData({Key? key});

  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      print(snapshot.data!.docs[index]);
                    },
                    title: Text(snapshot.data!.docs![index]["name"].toString()),
                    subtitle: Text(snapshot.data!.docs![index]["email"].toString()),
                  );
                },
              );
            }
            return Text('Error');
          },
        ),
      ),
    );
  }
}