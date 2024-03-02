import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Models/User.dart';

class FirestoreService {
  // Instance Singleton
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();
  int userId = -999;
  List<String> categorie = [];
  User currentUser = User(
      login: "",
      password: "",
      adress: "",
      city: "",
      birthday: "",
      postalCode: "",
      id: -999);
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _activitiesCollectionReference =
      FirebaseFirestore.instance.collection('activites');
  final CollectionReference _cartsCollectionReference =
      FirebaseFirestore.instance.collection('panier');

  int getUserId() {
    return userId;
  }

  void setUserId(int id) {
    userId = id;
  }

  User getCurrentUser() {
    return currentUser;
  }

  void setCurrentUser(User user) {
    currentUser = user;
  }

  List<String> getCategorie() {
    categorie.sort((a, b) => a == "Autre" ? 1 : -1);
    return categorie;
  }

  void setCategorie(String cat) {
    categorie.add(cat);
  }

  Future<bool> signIn(String login, String password) async {
    if (login.isNotEmpty) {
      try {
        var value = await _usersCollectionReference.doc(login).get();
        if (value.exists) {
          User user = User.fromJson(value.data() as Map<String, dynamic>);
          user.login = login;
          setCurrentUser(user);
          if (user.password == password) {
            setUserId(user.id);
            return true;
          } else {
            return false;
          }
        } else {
          print("Login does not exist");
          return false;
        }
      } catch (e) {
        print("Error: $e");
        // Gérer l'erreur ici, par exemple, renvoyer un message d'erreur à l'interface utilisateur.
        return false;
      }
    } else {
      throw Exception("Login cannot be null or empty");
    }
  }

  Future<bool> signUp(User user) async {
    try {
      await _usersCollectionReference.doc(user.login).set({
        "id": user.id,
        "login": user.login,
        "password": user.password,
        "adress": user.adress,
        "city": user.city,
        "birthday": user.birthday,
        "postalCode": user.postalCode,
      });
      return true;
    } catch (e) {
      print("signUp: $e");
      return false;
    }
  }

  Future<int> getNextUserId() async {
    int id = -999;
    try {
      // parcourir tous les documents de la collection users et récupérer le plus grand id User
      var value = await _usersCollectionReference.get();
      value.docs.forEach((element) {
        User user = User.fromJson(element.data() as Map<String, dynamic>);
        if (user.id > id) {
          id = user.id;
        }
      });
      id++;
    } catch (e) {
      print("getNextUserId: $e");
    }
    return id;
  }

  Future<List<Activity>> getActivities({String? categorie}) async {
    List<Activity> activities = [];
    try {
      var value = await _activitiesCollectionReference.get();
      value.docs.forEach((element) {
        Activity activity =
            Activity.fromJson(element.data() as Map<String, dynamic>);
        if (!getCategorie().contains(activity.categorie)) {
          setCategorie(activity.categorie);
        }
        if (categorie != null && activity.categorie == categorie) {
          activities.add(activity);
        } else if (categorie == null || categorie == "") {
          activities.add(activity);
        }
      });
    } catch (e) {
      print("getActivities: $e");
    }

    return activities;
  }
  Future<void> getCategories() async {
    try {
      var value = await _activitiesCollectionReference.get();
      value.docs.forEach((element) {
        Activity activity =
            Activity.fromJson(element.data() as Map<String, dynamic>);
        if (!getCategorie().contains(activity.categorie)) {
          setCategorie(activity.categorie);
        }
      });
    } catch (e) {
      print("getCategories: $e");
    }
  }

  Future<void> addActivityToCart(int activityId) async {
    try {
      // Get the current user's ID
      String userId = getUserId().toString();

      // Update the document using an array containing the activityId
      await _cartsCollectionReference.doc("activities").update({
        userId: FieldValue.arrayUnion([activityId]),
      });
    } catch (e) {
      print("addActivityToCart: $e");
    }
  }

  Future<List<Activity>> getActivitiesFromCart({String? category}) async {
    List<Activity> activities = [];
    List<int> activityIdsList = [];
    try {
      var value = await _cartsCollectionReference.doc("activities").get();
      if (value.exists) {
        List<dynamic> activityIds =
            (value.data() as Map<String, dynamic>)[getUserId().toString()];
        activityIds.forEach((element) async {
          activityIdsList
              .add(element); // ajout de l'id de l'activité dans la liste
        });
        var activites = await getActivities();
        
        activites.forEach((activity) {
          if (activityIdsList.contains(activity.id) &&
              category != null &&
              activity.categorie == category) {
            activities.add(activity);
          } else if (activityIdsList.contains(activity.id) &&
              category == null) {
            activities.add(activity);
          }
        });
      }
    } catch (e) {
      print("getActivitiesFromCart: $e");
    }
    return activities;
  }

  Future<bool> removeActivityFromCart(int activityId) async {
    try {
      // Get the current user's ID
      String userId = getUserId().toString();
      // Update the document using an array containing the activityId
      await _cartsCollectionReference.doc("activities").update({
        userId: FieldValue.arrayRemove([activityId]),
      });
      return true;
    } catch (e) {
      print("removeActivityFromCart: $e");
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await _usersCollectionReference.doc(user.login).update({
        "login": user.login,
        "password": user.password,
        "adress": user.adress,
        "city": user.city,
        "birthday": user.birthday,
        "postalCode": user.postalCode,
      });
      return true;
    } catch (e) {
      print("updateUser: $e");
      return false;
    }
  }

  Future<bool> addActivity(Activity activity) async {
    try {
      await _activitiesCollectionReference.doc().set({
        "id": activity.id,
        "titre": activity.titre,
        "lieu": activity.lieu,
        "prix": activity.prix,
        "image": activity.image,
        "categorie": activity.categorie,
        "nbParticipants": activity.nbParticipants
      });
      return true;
    } catch (e) {
      print("Add activity: $e");
      return false;
    }
  }

  Future<int> getNextActivityId() async {
    int id = -999;
    try {
      // parcourir tous les documents de la collection users et récupérer le plus grand id User
      var value = await _activitiesCollectionReference.get();
      value.docs.forEach((element) {
        Activity activity =
            Activity.fromJson(element.data() as Map<String, dynamic>);
        if (activity.id > id) {
          id = activity.id;
        }
      });
      id++;
    } catch (e) {
      print("getNextUserId: $e");
    }
    return id;
  }

  Future<bool> removeActivity(int activityId) async {
    try {
      var activities = await _activitiesCollectionReference.get();
      // Parcourir les documents récupérés
      for (var document in activities.docs) {
        // Convertir chaque document en objet Activity
        Activity current =
            Activity.fromJson(document.data() as Map<String, dynamic>);
        // Vérifier si l'ID correspond
        if (activityId == current.id) {
          // Supprimer le document correspondant
          await _activitiesCollectionReference.doc(document.id).delete();
          // Indiquer que la suppression a réussi
          return true;
        }
      }
      // Si aucun document ne correspond à l'ID donné, retourner false
      return false;
    } catch (e) {
      // Gérer les erreurs éventuelles
      print("removeActivity: $e");
      return false;
    }
  }

  Future<bool> updateActivity(Activity activity) async {
    try {
      var activities = await _activitiesCollectionReference.get();
      // Parcourir les documents récupérés
      for (var document in activities.docs) {
        // Convertir chaque document en objet Activity
        Activity current =
            Activity.fromJson(document.data() as Map<String, dynamic>);
        // Vérifier si l'ID correspond
        if (activity.id == current.id) {
          // Mettre à jour le document correspondant
          await _activitiesCollectionReference.doc(document.id).update({
            "titre": activity.titre,
            "lieu": activity.lieu,
            "prix": activity.prix,
            "image": activity.image,
            "categorie": activity.categorie,
            "nbParticipants": activity.nbParticipants
          });
          // Indiquer que la mise à jour a réussi
          return true;
        }
      }
      // Si aucun document ne correspond à l'ID donné, retourner false
      return false;
    } catch (e) {
      print("updateActivity: $e");
      return false;
    }
  }
}
