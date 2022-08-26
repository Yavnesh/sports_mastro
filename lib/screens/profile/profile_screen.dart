import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final List<Map> collections = [
    {"title": "Food joint", "image": "https://img.freepik.com/free-photo/sports-tools_53876-138077.jpg?w=1380&t=st=1660761160~exp=1660761760~hmac=c0aaa6e41c2af8185c25a9e6ea903232319579ce6915d52b2454467172c83791"},
    {"title": "Photos", "image": "https://img.freepik.com/free-vector/hand-drawn-national-sports-day-illustration_23-2149008413.jpg?w=1380&t=st=1660761191~exp=1660761791~hmac=792cb5940ba1298b271215623e439f7c17d1b3e4e61c9a390ae1600eea6717d9"},
    {"title": "Travel", "image": "https://img.freepik.com/free-vector/gradient-national-sports-day-illustration_23-2148995774.jpg?w=826&t=st=1660761194~exp=1660761794~hmac=3e96b62d5d4cdb56e4c72ba4f07b7cd735327900c620ca38c2789660feeaf23d"},
    {"title": "Nepal", "image": "https://img.freepik.com/free-psd/footbal-club-training-camp-flyer_23-2148406213.jpg?w=826&t=st=1660761199~exp=1660761799~hmac=419905a3044f47eee11ef50f9a0c082f4f7086ae2efe46af7f31a4b4630af648"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo.shade300, Colors.indigo.shade500]),
            ),
          ),
          ListView.builder(
            itemCount: 7,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildSectionHeader(context);
    if (index == 2) return _buildCollectionsRow();
    if (index == 3)
      return Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          child: Text("Most liked posts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
    return _buildListItem();
  }

  Widget _buildListItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.network("https://img.freepik.com/free-vector/flat-national-sports-day-illustration_23-2148991395.jpg?w=826&t=st=1660761203~exp=1660761803~hmac=d2206eb9ba941d257d7d46414ce57bc670aae6eb874c77ee2843c1b5e1c25b57", fit: BoxFit.cover),
      ),
    );
  }

  Container _buildSectionHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Collection",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Create new",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Container _buildCollectionsRow() {
    return Container(
      color: Colors.white,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              width: 150.0,
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(collections[index]['image'],
                              fit: BoxFit.cover))),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(collections[index]['title'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ],
              ));
        },
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Mebina Nepal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("UI/UX designer | Foodie | Kathmandu"),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "302",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Posts".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "10.3K",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Followers".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Following".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage("https://img.freepik.com/free-psd/3d-illustration-bald-person_23-2149436183.jpg?w=826&t=st=1660761383~exp=1660761983~hmac=bdbc4bd7e44962ae05bc14e2cfd4bd5b598e84ec6ca806dfe11e989d91964e0b",),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}