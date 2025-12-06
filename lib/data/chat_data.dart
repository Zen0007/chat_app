class ContactData {
  ContactData(this.name);
  final String name;
}

const String currentName = "root";

final contact = {
  "root": {
    "password": "root123",
    "email": "root@gmail.com",
    "contact": {
      "asta": [
        {
          "message":
              "you too  sssssssssssssssssssssss1111111111111111111111111111111111111",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too ",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too ",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too ",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too ",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message": "you too  sssssssssssssssssssssss",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
        {
          "message":
              "you too  ssssssssssssssssss 11111111111111111111111111111111111111111111111111111111111111111111111111111111111sssss",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message": "you too ",
          "date": "${DateTime.now()}",
          "isMe": true,
          "userName": "yuno"
        },
        {
          "message":
              "you too  ssssssssssssssssssssssseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
          "date": "${DateTime.now()}",
          "isMe": false,
          "userName": "yuno"
        },
      ],
      "yuno": [],
    },
  }
};

final infoContact = {
  "luck": "assets/images/graph.png",
  "yuno": "assets/images/graph.png",
};

void addChat(String name, Map<String, String> chat) {
  print((contact["root"]!["contact"] as Map)[name]);
  (contact["root"]!["contact"] as Map)[name].add(chat);
}

List<ContactData> dataConatct() {
  Map<String, List> data = contact["root"]!["contact"] as Map<String, List>;
  List<ContactData> result = [];
  for (var element in data.entries) {
    result.add(ContactData(element.key));
  }

  return result;
}

List getChat(String name) {
  final contacts = contact["root"]!["contact"] as Map;
  final chat = contacts[name] as List;

  return chat;
}


//   {
//     "name": "asta",
//     "text": "heiii",
//     "dateTime": "10.12",
//     "image": "assets/images/graph.png",
//   },
//   {
//     "name": "yuno",
//     "text": "heiii",
//     "dateTime": "10.12",
//     "image": "assets/images/graph.png",
//   },