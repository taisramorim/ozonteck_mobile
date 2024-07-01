import 'package:cart_repository/cart_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {

  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUser user);

  Future<MyUser> getMyUser(String myUserId);
  
  Future<String> getCurrentUserId();

  Future<String> uploadPicture(String file, String userId);
  
  Future<bool> checkRecruiterUsername(String username);

  Future<void> addUserWithRecruiter(MyUser user, String recruiterUsername);

  Future<MyUser?> getUserByUsername(String username);

  Future<void> addUserToRecruitedUsers(String recruiterUsername, String newUserId);

  Future<List<MyUser>> getUserNetwork(String userId);

  Future<List<MyUser>> getRecruitedUsers(String userId);

  Future<void> updateUserPoints(String userId, int pointsToAdd);

  Future<void> updateUserEarnings(String userId, int earningsToAdd);

  Future<void> addProductToCart(String userId, CartItem cartItem);

  Future<void> purchaseProducts(String userId);

  Future<void> distributePointsToNetwork(String userId, int totalSpent);

  Future<void> updateUserInfo(String userId, {String? name, String? email});
  
}