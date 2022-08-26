import 'package:flutter/material.dart';

import '../models/your_category_model.dart';

class YourCategoriesPage extends StatefulWidget {
  const YourCategoriesPage({Key? key}) : super(key: key);

  @override
  State<YourCategoriesPage> createState() => _YourCategoriesPageState();
}

class _YourCategoriesPageState extends State<YourCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your Categories',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 280,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: 140.0,
                          width: 170.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(hotels[index].imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(2.0),),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.sensors_rounded,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "LIVE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        hotels[index].title!,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "#${hotels[index].description!}",
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '\$${hotels[index].price} / night',
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '${hotels[index].rating}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16.0,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
