import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key, required this.name, this.text, this.dataTime});
  final String name;
  final String? text;
  final String? dataTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Container(
            color: Colors.deepOrange[200],
            child: Center(
              child: Text(name),
            ),
          ),
        )),
        child: Card(
          color: Colors.blueAccent[100],
          child: SizedBox(
            height: 65,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/graph.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$dataTime",
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "$text",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
