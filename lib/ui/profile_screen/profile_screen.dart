import 'dart:convert';
import 'dart:io';

import 'package:customchatgpt/ui/profile_screen/profile_screen_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/api_urls.dart';
import '../../routes/routes_name.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utilities/hive/user_hive_model.dart';
import '../../utilities/utils.dart';
import '../../widgets/circular_letter_avatar.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProfileScreen();

}

class _ProfileScreen extends State {
  Box userBox = Hive.box<UserHiveModel>('userBox');
  late UserHiveModel hiveUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? imagePath = null;
  String? imageBase64 = null;
  var viewmodel = ProfileViewModel();
  bool isUpdating = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiveUser = userBox.get("currentUser");
    getProfile(hiveUser.getUserId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile", style: TextStyle(color: Colors.white)),

        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                showImageSourceDialog(context, (file, base64) {
                  print(file.path);
                  print(base64);
                  imagePath = file.path;
                  imageBase64 = base64;
                  setState(() {});
                });
                //   print(image?["file"].toString());
              },
              child: imageBase64 != null
                  ? ClipOval(
                    child: Image.memory(base64Decode(imageBase64!),height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,),
                  )
                  : imagePath != null
                  ? ClipOval(
                      child: Image.network(
                         imagePath!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    )
                  : circularAvatar(name: hiveUser.getUserName, radius: 50),
            ),
            const SizedBox(height: 16),
            _profileInfoCard(),
            const SizedBox(height: 16),
            _subscriptionCard(context, hiveUser.subscriptionFriendlyName),
            const SizedBox(height: 24),
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF9B5CFF), Color(0xFF5B8CFF)],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 90,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF7B61FF),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Profile Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorSecandory,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _inputField(
            icon: Icons.person_outline,
            hint: hiveUser.getUserName,
            controller: nameController,
            isenable: true,
          ),
          const SizedBox(height: 12),
          _inputField(
            icon: Icons.email_outlined,
            hint: hiveUser.getEmail,
            controller: emailController,
            isenable: false,
          ),
        ],
      ),
    );
  }

  Widget _subscriptionCard(BuildContext context, String subName) {
    print(subName);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subscription",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorSecandory,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.UpgradeToPremiumScreen);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorPrimary,
                        ),
                      ),
                      Text(
                        hiveUser.subscriptionFriendlyName == "Free"
                            ? "Free features"
                            : hiveUser.subscriptionFriendlyName == "Standard"
                            ? "Limited Features"
                            : hiveUser.subscriptionFriendlyName == "Premium+"
                            ? "Full Features"
                            : "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    "Click to update subscription",
                    style: TextStyle(color: ColorPrimary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: ColorPrimary,
              ),
              onPressed: () {

                if (nameController.text.length>1){
                      updateProfile({ "id": hiveUser.getUserId,
                        "first_name": nameController.text,
                        "email":  hiveUser.getEmail,
                        "imageurl": imageBase64.toString()});
                }else {
                  mUtils.toastMessage("Enter name");
                };
              },

              child: isUpdating?CircularProgressIndicator(color: Colors.white): const Text(
                "Update profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: ColorSecandory),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, color: ColorSecandory),
        label: const Text("Log Out", style: TextStyle(color: ColorSecandory)),
        onPressed: () {
          Box userBox = Hive.box<UserHiveModel>('userBox');
          userBox.clear();
          Navigator.pushNamed(context, RouteNames.LoginScreen);
        },
      ),
    );
  }

  Widget _inputField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    required bool isenable,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: ColorPrimary),

        enabled: isenable,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>?> pickImage(ImageSource source) async {
    // Check camera permission if source is camera
    if (source == ImageSource.camera) {
      PermissionStatus status = await Permission.camera.status;

      if (!status.isGranted) {
        status = await Permission.camera.request();

        if (!status.isGranted) {
          return null;
        }
      }
    }

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (pickedFile == null) return null;

    File file = File(pickedFile.path);

    List<int> bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);

    return {"file": file, "base64": base64Image};
  }

  void showImageSourceDialog(
    BuildContext context,
    Function(File file, String base64) onImageSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);

                  var result = await pickImage(ImageSource.camera);
                  if (result != null) {
                    onImageSelected(result["file"], result["base64"]);
                  }
                },
              ),

              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context);

                  var result = await pickImage(ImageSource.gallery);
                  if (result != null) {
                    onImageSelected(result["file"], result["base64"]);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getProfile(String getUserId) async {

    var response = await viewmodel.getProfile(getUserId);
    if (response?.code == 200) {
      hiveUser.setUserName(response?.data["first_name"]);
      if (response!.data["image_url"]!=null) {
        imagePath = ApiUrls.BASE_URL+
            response!.data["image_url"].toString().replaceFirst("/", "");

        hiveUser.setImageUrl(ApiUrls.BASE_URL+
            response!.data["image_url"].toString().replaceFirst("/", ""));
      }else {
        imagePath = null;
      }
      nameController.text = hiveUser.getUserName;
      emailController.text = hiveUser.getEmail;
      setState(() {});
    } else {
      mUtils.toastMessage("Some thing went wrong.");
    }
  }

  Future<void> updateProfile(Map<String, String> data) async {

    setState(() {
      isUpdating =true;
    });
    var reponse = await viewmodel.updateProfile(data);
    setState(() {
      isUpdating = false;
    });
    if (reponse?.code == 200) {
      hiveUser.setUserName(reponse?.data["first_name"]);
      if (reponse!.data["image_url"]!=null) {
        imagePath = ApiUrls.BASE_URL+
            reponse!.data["image_url"].toString().replaceFirst("/", "");
        hiveUser.setImageUrl(ApiUrls.BASE_URL+
            reponse!.data["image_url"].toString().replaceFirst("/", ""));
      }else {
        imagePath=null;
      }
      setState(() {});
    } else {
      mUtils.toastMessage("Some thing went wrong. please try again.");
    }
  }
}
