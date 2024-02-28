import 'dart:io';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:get/get.dart';
import '../Controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.username});
  final String? username;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    void initState() {
      controller.nameController.text = widget.username!;
      super.initState();
    }
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: boldText(text: 'Edit Profile', size: 16),
            actions: [
              controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(white),
                    ))
                  : TextButton(
                      onPressed: () async {
                        controller.isLoading(true);
                        //if image is not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImagelink =
                              controller.snapshotData['imgurl'];
                        }
                        //if old password matches database

                        if (controller.snapshotData['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthpassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text,
                          );
                          await controller.updateProfile(
                              imgurl: controller.profileImagelink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text);

                          VxToast.show(context, msg: "Updated");
                        } else if (controller
                                .oldpassController.text.isEmptyOrNull &&
                            controller.newpassController.text.isEmptyOrNull) {
                          await controller.updateProfile(
                              imgurl: controller.profileImagelink,
                              name: controller.nameController.text,
                              password: controller.snapshotData['password']);
                        } else {
                          VxToast.show(context, msg: "Some error occured");
                          // controller.isLoading(false);
                        }
                      },
                      child: normalText(text: save))
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              controller.snapshotData['imgurl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imgurl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imgurl'],
                          width: 74,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: normalText(text: "Change Image", color: fontGrey)),
              10.heightBox,
              Divider(
                color: white,
              ),
              customTextField(
                  label: name,
                  hint: "eg. Vasu Langdecha",
                  controller: controller.nameController),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change your password")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  label: confirmpass,
                  hint: passwordHint,
                  controller: controller.newpassController),
            ],
          ),
        ),
      ),
    );
  }
}
