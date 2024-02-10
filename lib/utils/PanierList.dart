import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';

class PanierList extends StatefulWidget {
  final Function(int) deleteActivityFromCart;
  PanierList({super.key, required this.panierList, required this.deleteActivityFromCart});

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
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(activity.titre),
                  subtitle: Column(
                    children: <Widget>[
                      Text(activity.lieu),
                      Text("${activity.prix}€"),
                      // Afficher l'image à partir de l'URL
                      Image.network(
                        activity.image,
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => widget.deleteActivityFromCart(activity.id),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

