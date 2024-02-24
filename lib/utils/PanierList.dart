import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';

class PanierList extends StatefulWidget {
  final Function(int) deleteActivityFromCart;
  const PanierList({super.key, required this.panierList, required this.deleteActivityFromCart});

  final List<Activity> panierList;
  
  @override
  State<PanierList> createState() => _PanierListState();
}

class _PanierListState extends State<PanierList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.panierList.length,
      itemBuilder: (context, index) {
        var activity = widget.panierList[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      activity.titre,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          activity.lieu,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Prix: ",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              "${activity.prix}€",
                              style: const TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    activity.image,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => widget.deleteActivityFromCart(activity.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
