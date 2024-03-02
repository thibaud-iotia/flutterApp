import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Screens/CurrentActivityScreen.dart';

class ActivitiesList extends StatefulWidget {
  final Function(int) handleDeleteActivity;
  const ActivitiesList({super.key, required this.activitiesList, required this.handleDeleteActivity});

  final List<Activity> activitiesList;

  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  bool isEditing = false;

  void handleTapActivity(Activity activity) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CurrentActivityScreen(activity: activity, isEditing: false)));
  }

  void handleEditActivity(Activity currentActivity) {
    setState(() {
      isEditing = true;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CurrentActivityScreen(activity: currentActivity, isEditing: isEditing)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.activitiesList.length,
      itemBuilder: (context, index) {
        var activity = widget.activitiesList[index];
        return GestureDetector(
          onTap: () => handleTapActivity(activity),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        activity.titre,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            activity.lieu,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${activity.prix}€",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        activity.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => handleEditActivity(activity),
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.handleDeleteActivity(activity.id),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
