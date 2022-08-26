import 'package:flutter/material.dart';

class Hotel {
  String? imageUrl;
  String? title;
  String? description;
  int? price;
  double? rating;

  Hotel({this.description, this.imageUrl, this.price, this.rating, this.title});
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'https://cdn.pixabay.com/photo/2016/10/30/05/43/asia-1782429__340.jpg',
    title: 'Ichha Hotel Ichha Hotel',
    description: 'A Four Start Hotel in Bara',
    price: 180,
    rating: 4.5,
  ),
  Hotel(
    imageUrl: 'https://cdn.pixabay.com/photo/2014/10/23/21/01/building-500295__340.jpg',
    title: 'Hotel Merriot Hotel Merriot',
    description: 'A five star Hotelin Kathmandu',
    price: 180,
    rating: 4.5,
  ),
  Hotel(
    imageUrl: 'https://cdn.pixabay.com/photo/2018/02/26/14/22/venice-3183168__340.jpg',
    title: 'Yak and Yati',
    description: 'A five Star hotel in Kathmandu',
    price: 180,
    rating: 4.5,
  ),
  Hotel(
    imageUrl: 'https://cdn.pixabay.com/photo/2018/04/25/09/26/eiffel-tower-3349075__340.jpg',
    title: 'Hotel Star',
    description: 'A Five star hotel in thamel',
    price: 180,
    rating: 4.5,
  )
];
