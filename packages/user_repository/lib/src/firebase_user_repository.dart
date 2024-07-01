import 'dart:developer';
import 'dart:io';

import 'package:cart_repository/src/models/cart_item.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Stream<User?> get user {
    try {
      return _firebaseAuth.authStateChanges().map((firebaseUser) {
        final user = firebaseUser;
        return user;
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
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
        password: password,
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
      await _firebaseAuth.sendPasswordResetEmail(email: email);
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
      DocumentSnapshot doc = await usersCollection.doc(myUserId).get();
      return MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()! as Map<String, dynamic>));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> getCurrentUserId() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user signed in');
    }
  }

  @override
  Future<String> uploadPicture(String filePath, String userId) async {
    try {
      File imageFile = File(filePath);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('user_images/$userId');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    }  catch (e) {
      log('Error uploading picture: $e');
      rethrow;
    }
  }

  @override
  Future<MyUser?> getUserByUsername(String username) async {
    try {
      QuerySnapshot query = await usersCollection.where('username', isEqualTo: username).limit(1).get();
      if (query.docs.isNotEmpty) {
        return MyUser.fromEntity(MyUserEntity.fromDocument(query.docs.first.data()! as Map<String, dynamic>));
      }
      return null;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> checkRecruiterUsername(String username) async {
    try {
      MyUser? user = await getUserByUsername(username);
      return user != null;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addUserToRecruitedUsers(String recruiterUsername, String newUserId) async {
    try {
      MyUser? recruiter = await getUserByUsername(recruiterUsername);
      if (recruiter != null) {
        await usersCollection.doc(recruiter.id).update({
          'recruitedUsers': FieldValue.arrayUnion([newUserId])
        });
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addUserWithRecruiter(MyUser user, String recruiterUsername) async {
    try {
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
          return MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()! as Map<String, dynamic>));
        }).toList();
        for (var a in users) {
          if (a.recruitedUsers.contains(recruiter.id)) {
            a.earnings += 5;
            a.points += 5;
            await usersCollection.doc(a.id).update(a.toEntity().toDocument());
            for (var b in users) {
              if (b.recruitedUsers.contains(a.id)) {
                b.earnings += 3;
                b.points += 3;
                await usersCollection.doc(b.id).update(b.toEntity().toDocument());
                for (var c in users) {
                  if (c.recruitedUsers.contains(b.id)) {
                    c.earnings += 2;
                    c.points += 2;
                    await usersCollection.doc(c.id).update(c.toEntity().toDocument());
                    for (var d in users) {
                      if (d.recruitedUsers.contains(c.id)) {
                        d.earnings += 1;
                        d.points += 1;
                        await usersCollection.doc(d.id).update(d.toEntity().toDocument());
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUser>> getUserNetwork(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception("User ID cannot be empty");
      }

      List<MyUser> network = [];
      MyUser user = await getMyUser(userId);

      for (String recruitId in user.recruitedUsers) {
        MyUser recruit = await getMyUser(recruitId);
        network.add(recruit);
        network.addAll(await getUserNetwork(recruit.id));
      }

      return network;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUser>> getRecruitedUsers(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception("User ID cannot be empty");
      }

      MyUser user = await getMyUser(userId);
      List<MyUser> recruitedUsers = [];
      for (String recruitId in user.recruitedUsers) {
        MyUser recruit = await getMyUser(recruitId);
        recruitedUsers.add(recruit);
      }

      return recruitedUsers;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserPoints(String userId, int pointsToAdd) async {
    try {
      usersCollection.doc(userId).update({
        'points': FieldValue.increment(pointsToAdd),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserEarnings(String userId, int earningsToAdd) async {
    try {
      usersCollection.doc(userId).update({
        'earnings': FieldValue.increment(earningsToAdd),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addProductToCart(String userId, CartItem cartItem) async {
    try {
      DocumentSnapshot doc = await usersCollection.doc(userId).get();
      MyUser user = MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()! as Map<String, dynamic>));
      user.cart.add(cartItem);
      await usersCollection.doc(userId).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }

  }

  @override
  Future<void> purchaseProducts(String userId) async {
    try {
      DocumentSnapshot doc = await usersCollection.doc(userId).get();
      MyUser user = MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()! as Map<String, dynamic>));

      int totalPoints = user.cart.fold(0, (sum, item) => sum + item.totalPoints);
      user.points += totalPoints;

      await updateUserPoints(userId, totalPoints);
      await distributePointsToNetwork(userId, user.cart.fold(0, (sum, item) => sum + item.totalPrice));

      user.cart.clear();
      await usersCollection.doc(userId).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }

  }

  @override
  Future<void> distributePointsToNetwork(String userId, int totalSpent) async {
    try {
      MyUser user = await getMyUser(userId);
      List<MyUser> network = await getUserNetwork(userId);

      for (String recruiterId in user.recruitedUsers) {
        await updateUserPoints(recruiterId, (totalSpent * 0.1).toInt());
        await updateUserEarnings(recruiterId, (totalSpent * 0.1).toInt());
      }

      for (MyUser recruit in network) {
        await updateUserPoints(recruit.id, (totalSpent * 0.05).toInt());
        await updateUserEarnings(recruit.id, (totalSpent * 0.05).toInt());
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  updateUserInfo(String userId, {String? name, String? email}) async {
    try {
      Map<String, dynamic> updatedData = {};
      if (name != null) updatedData['name'] = name;
      if (email != null) updatedData['email'] = email;
      await _firestore.collection('users').doc(userId).update(updatedData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
