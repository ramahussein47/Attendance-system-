import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  // Get the collection for the classes
  final CollectionReference classesCollection =
      FirebaseFirestore.instance.collection('classes');

  // Add a class to the database
  Future<void> addClass(String className, String format) {
    return classesCollection.add({
      'className': className,
      'format': format,
      'timestamp': Timestamp.now(),
    });
  }

  // Stream to get all classes ordered by timestamp
  Stream<QuerySnapshot> getClassesStream() {
    return classesCollection.orderBy('timestamp', descending: true).snapshots();
  }

  // Update class details in the database
  Future<void> updateClass(String classname, String docId, String format) {
    return classesCollection.doc(docId).update({
      'className': classname,
      'format': format,
    });
  }

  // Method to fetch class names as a list
  Future<List<String>> getClasses() async {
    try {
      QuerySnapshot querySnapshot = await classesCollection.get();

      List<String> classes = [];
      querySnapshot.docs.forEach((doc) {
        classes.add(doc['className']);
      });

      return classes;
    } catch (e) {
      // Handle errors
      print('Error fetching classes: $e');
      throw e;
    }
  }

                        Future<void>addStudents(String classId,String studetName,String studentId)async{
                          try {
                               DocumentReference classDocRef=classesCollection.doc(classId);
                                  // check if the class exits
                                   DocumentSnapshot classDoc=await classDocRef.get();
                                    if(!classDoc.exists){
                                        throw Exception('Class with the ID $classId does not exits');
                                    }
                                      // add the student details to the class
                                       await classDocRef.collection('students').doc(studentId).set({
                                          'name':studetName,
                                          'id':studentId,
                                       })
;
                          } catch (e) {
                               rethrow;
                          }
                        }
                        // function for getting the list from the database
                         Future <void>getStudents(String className)async{
                          QuerySnapshot querySnapshot=await classesCollection.get();
                            List<String> Students=[];
                            querySnapshot.docs.forEach((element) {


                            });

                         }


}
