import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
 
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      final user = firebaseUser; 
      return user;
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email, 
        password: password
      );
      String userId = user.user!.uid;
      myUser = myUser.copyWith(id: userId);
      await setUserData(myUser);
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
        );
    } catch (e) {
      log(e.toString());
      rethrow;
      }
    }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
      }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email
        );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
        MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
    Future<String> uploadPicture(String filePath, String userId) async {
      try {
        File imageFile = File(filePath);
        Reference firebaseStoreRef = FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');
        await firebaseStoreRef.putFile(imageFile);
        String url = await firebaseStoreRef.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(userId).update({'picture': url});

        return url;
      } catch (e) {
        log('Error uploading picture: $e');
        rethrow;
      }
    }

  @override
  Future<MyUser?> getUserByUsername(String username) async {
    QuerySnapshot query = await usersCollection.where('username', isEqualTo: username).limit(1).get();
    if (query.docs.isNotEmpty) {
      return MyUser.fromEntity(MyUserEntity.fromDocument(query.docs.first.data()! as Map<String, dynamic>));
    }
    return null;
  }

  @override
    Future<bool> checkRecruiterUsername(String username) async {
      MyUser? user = await getUserByUsername(username);
      return user != null;
    }

  @override
  Future<void> addUserToRecruitedUsers(String recruiterUsername, String newUserId) async {
    if (recruiterUsername.isEmpty) {
      throw Exception("Recruiter username cannot be empty");
    }
    MyUser? recruiter = await getUserByUsername(recruiterUsername);
    if (recruiter != null) {
      await usersCollection.doc(recruiter.id).update({
        'recruitedUsers': FieldValue.arrayUnion([newUserId])
      });
    }
  }

  @override
  Future<void> addUserWithRecruiter(MyUser user, String recruiterUsername) async {
    await setUserData(user);
    if (recruiterUsername.isEmpty || recruiterUsername == 'none') {
      return;
    }
    
    await addUserToRecruitedUsers(recruiterUsername, user.id);

    // Update earnings and points for upper levels
    MyUser? recruiter = await getUserByUsername(recruiterUsername);
    if (recruiter != null) {
      recruiter.earnings += 10;
      recruiter.points += 10;
      await usersCollection.doc(recruiter.id).update(recruiter.toEntity().toDocument());

      // Recursively update points and earnings for upper levels
      QuerySnapshot userSnapshot = await usersCollection.get();
      List<MyUser> users = userSnapshot.docs.map((doc) {
        return MyUser.fromEntity(MyUserEntity.fromDocument(doc.data() as Map<String, dynamic>));
      }).toList();
      for (var u in users) {
        if (u.recruitedUsers.contains(recruiter.id)) {
          u.earnings += 5;
          u.points += 5;
          await usersCollection.doc(u.id).update(u.toEntity().toDocument());
        }
      }
    }
  }

  @override
  Future<List<MyUser>> getUserNetwork(String userId) async {
    if (userId.isEmpty) {
      throw Exception("User ID cannot be empty");
    }
    
    List<MyUser> network = [];
    MyUser? user = await getMyUser(userId);

    for (String recruitId in user.recruitedUsers) {
      MyUser? recruit = await getMyUser(recruitId);
      network.add(recruit);
      network.addAll(await getUserNetwork(recruit.id));
        }
  
    return network;
  }
}