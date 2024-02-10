import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Screens/CurrentActivityScreen.dart';

class ActivitiesList extends StatefulWidget {
  const ActivitiesList({super.key, required this.activitiesList});

  final List<Activity> activitiesList;

  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {

  void handleTapActivity(Activity activity) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentActivityScreen(activity: activity)));
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.activitiesList.length,
      itemBuilder: (context, index) {
        var activity = widget.activitiesList[index];
        return Card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  onTap: () => handleTapActivity(activity),
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
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
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

