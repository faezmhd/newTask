import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
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
                    subtitle: Text(snapshot.data!.docs![index]["internship"].toString()),
                  );
                },
              );
            }
            return Text('No Data');
          },
        ),
      ),
    );
  }
}