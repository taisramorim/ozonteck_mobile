import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozonteck_mobile/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:ozonteck_mobile/blocs/update_user_info_bloc/update_user_info_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  //TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<MyUserBloc>().state.user;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
     // _addressController.text = user.address ?? '';
    }
  }

  void _updateProfile() {
    final user = context.read<MyUserBloc>().state.user;
    if (user != null) {
      context.read<UpdateUserInfoBloc>().add(UpdateUserInfo(
        user.id,
        name: _nameController.text,
        email: _emailController.text,
        //address: _addressController.text,
      ));
    }
  }

  void _uploadPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      context.read<UpdateUserInfoBloc>().add(UploadPicture(image.path, widget.userId));
    }
  }

  void _resetPassword() {
    context.read<UpdateUserInfoBloc>().add(ResetPassword(_emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _uploadPicture,
              child: BlocBuilder<MyUserBloc, MyUserState>(
                builder: (context, state) {
                  final user = state.user;
                  if (user != null && user.picture != null && user.picture!.isNotEmpty) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.picture!),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            //TextField(
              //controller: _addressController,
              //decoration: const InputDecoration(labelText: 'Address'),
            //),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Update Profile'),
            ),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Reset Password'),
            ),
            BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
              listener: (context, state) {
                if (state is UploadPictureSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture updated successfully!')));
                } else if (state is UploadPictureFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile picture')));
                } else if (state is UpdateUserInfoSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
                } else if (state is UpdateUserInfoFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
                } else if (state is ResetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset email sent!')));
                } else if (state is ResetPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to reset password')));
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
