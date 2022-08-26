import 'activity_model.dart';

class LiveStreaming {
  final String? title;
  final String? imageUrl;
  final String? uid;
  final String? displayName;
  final String? channelId;
  final startedAt;
  final int viewers;

  LiveStreaming(this.title, this.imageUrl, this.uid, this.displayName,
      this.channelId, this.startedAt, this.viewers);

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'imageUrl': imageUrl,
      'uid': uid,
      'displayName': displayName,
      'channelId': channelId,
      'startedAt': startedAt,
      'viewers': viewers,
    };
  }



  factory LiveStreaming.fromMap(Map<String, dynamic> map){
    return LiveStreaming(
        map['title'] ?? '',
        map['imageUrl'] ?? '',
        map['uid'] ?? '',
        map['displayName'] ?? '',
        map['channelId'] ?? '',
        map['startedAt'] ?? '',
        map['viewers']?.toInt() ?? 0,
    );
  }
}

List<Activity> activities = [
  Activity(
    imageUrl: 'https://cdn.pixabay.com/photo/2017/06/26/17/33/venice-2444521__340.jpg',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'https://cdn.pixabay.com/photo/2016/10/30/05/43/asia-1782429__340.jpg',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'https://cdn.pixabay.com/photo/2014/10/23/21/01/building-500295__340.jpg',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

// List<LiveStreaming> destinations = [
//   LiveStreaming(
//     imageUrl: 'https://cdn.pixabay.com/photo/2018/02/26/14/22/venice-3183168__340.jpg',
//     city: 'Venice',
//     country: '66.7k',
//     description: 'Visit Venice for an amazing and unforgettable adventure.',
//     activities: activities,
//   ),
//   LiveStreaming(
//     imageUrl: 'https://cdn.pixabay.com/photo/2018/04/25/09/26/eiffel-tower-3349075__340.jpg',
//     city: 'Paris',
//     country: '1k',
//     description: 'Visit Paris for an amazing and unforgettable adventure.',
//     activities: activities,
//   ),
//   LiveStreaming(
//     imageUrl: 'https://cdn.pixabay.com/photo/2020/11/30/07/16/temple-5790082__340.jpg',
//     city: 'Kathmandu',
//     country: '56k',
//     description: 'Visit  Nepal for an amazing and unforgettable adventure.',
//     activities: activities,
//   ),
//   LiveStreaming(
//     imageUrl: 'https://cdn.pixabay.com/photo/2018/04/25/09/26/eiffel-tower-3349075__340.jpg',
//     city: 'Sao Paulo',
//     country: '20k',
//     description: 'Visit Sao Paulo for an amazing and unforgettable adventure.',
//     activities: activities,
//   ),
//   LiveStreaming(
//     imageUrl: 'https://cdn.pixabay.com/photo/2017/08/03/20/39/sunset-2578297__340.jpg',
//     city: 'New York City',
//     country: '1.2m',
//     description: 'Visit New York for an amazing and unforgettable adventure.',
//     activities: activities,
//   ),
// ];