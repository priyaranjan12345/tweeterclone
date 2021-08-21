import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:twitterclone/models/messagemodel.dart';
import 'package:twitterclone/pages/post_tweet.dart';
import 'package:twitterclone/services/firebaseservice.dart';
import 'package:twitterclone/widgets/mywidgets.dart';

class ChildHome extends StatefulWidget {
  const ChildHome({Key key}) : super(key: key);

  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  final firestore = FirebaseFirestore.instance;

  List<MessageModel> listmodel = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.context.height * 0.9,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection("twitted_data")
                .orderBy("last_modified_date", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var docs = snapshot.data.docs;
                if (listmodel != null) {
                  listmodel.clear();
                }

                for (var e in docs) {
                  Timestamp timestamp = e.get('last_modified_date');
                  var udatetime =
                      DateFormat.yMMMd().add_jm().format(timestamp.toDate());
                  Timestamp timestamp1 = e.get('created_date');
                  var cdatetime =
                      DateFormat.yMMMd().add_jm().format(timestamp1.toDate());
                  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                  MessageModel model = MessageModel(
                    udatetime.toString(),
                    cdatetime.toString(),
                    data['message'],
                    e.id,
                  );
                  listmodel.add(model);
                }
                return ItemList(listmodel);
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No Data Found"));
              } else if (snapshot.hasError) {
                return const Center(child: Text("404 error"));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Align(
            alignment: const Alignment(0.9, 0.92),
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => TweetPage(() {
                      
                      MyWidgets().mysnacbar("Info", "Data posted sucessfully");
                    }));
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<MessageModel> listmodel;
  const ItemList(this.listmodel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: listmodel.length,
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey[700],
      ),
      itemBuilder: (BuildContext context, int index) {
        return Tiles(listmodel[index]);
      },
    );
  }
}

class Tiles extends StatelessWidget {
  final MessageModel model;
  const Tiles(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            child: const ProfileImage(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "John Smith",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            " @ Jhonsmith__124",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          botomSheet(model.id, model.message);
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created : ${model.createddate}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Last modified : ${model.lastmodifieddate}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 6,
                      ),
                      AutoSizeText(
                        model.message,
                        softWrap: true,
                        wrapWords: true,
                        //textAlign: TextAlign.start,
                        maxLines: 7,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/reply.png',
                                    height: 22,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Expanded(child: Text("9"))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {},
                              icon: Row(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                          'assets/images/retweet.png')),
                                  const Expanded(child: Text("6"))
                                ],
                              )),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              children: const [
                                Expanded(child: Icon(Icons.favorite_outline)),
                                Expanded(child: Text("8"))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              children: const [
                                Expanded(child: Icon(Icons.share_outlined)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

botomSheet(String id, String msg) {
  Get.bottomSheet(
    Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text("Edit tweet"),
          onTap: () {
            Get.back();
            botomSheetEdit(id, msg);
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete_outline_outlined),
          title: const Text("Delete tweet"),
          onTap: () {
            Get.back();
            Get.defaultDialog(
              middleText: "Are you sure to delete",
              confirmTextColor: Colors.white,
              onConfirm: () async {
                bool isdeleted = await deleteData(id);
                if (isdeleted) {
                  Get.back();
                  MyWidgets().mysnacbar("Alert", "Data deleted sucessfully");
                } else {
                  Get.back();
                  MyWidgets().dialogmsg("Data not deleted");
                }
              },
              onCancel: () {
                Get.back();
              },
            );
          },
        )
      ],
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}

TextEditingController message = TextEditingController();

botomSheetEdit(String id, String msg) {
  message.text = msg;
  Get.bottomSheet(
    Column(
      children: [
        Container(
          width: Get.context.width * 0.9,
          height: Get.context.height * 0.3,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
          child: TextField(
            maxLines: 10,
            maxLength: 280,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusColor: Colors.white,
              hoverColor: Colors.white,
              hintText: "What's happening ?",
            ),
            controller: message,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            bool isupdated = await updateData(id, message.text);
            if (isupdated) {
              Get.back();
              MyWidgets().dialogmsg("Data updated sucessfully");
            } else {
              Get.back();
              MyWidgets().dialogmsg("Data not updated");
            }
          },
          child: const Text("Update Tweet"),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
