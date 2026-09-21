import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';
import 'package:xcash_app/core/utils/my_strings.dart';
import 'package:xcash_app/core/utils/style.dart';
import 'package:xcash_app/data/model/authorization/authorization_response_model.dart';
import 'package:xcash_app/data/services/api_service.dart';
import 'package:xcash_app/view/components/circle_icon_button.dart';
import 'package:xcash_app/view/components/snack_bar/show_custom_snackbar.dart';

class PreviewImage extends StatefulWidget {
  String url;
  PreviewImage({super.key, required this.url});

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  void initState() {
    widget.url = Get.arguments;
    super.initState();
  }

  String _localPath = '';

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        return directory.path;
      } else {
        return (await getExternalStorageDirectory())?.path ?? "";
      }
    } else if (Platform.isIOS) {
      return (await getApplicationDocumentsDirectory()).path;
    } else {
      return null;
    }
  }

  bool isdownloading = false;
  int selectedIndex = -1;
  String _getContentType(String extension) {
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'jpeg':
      case 'jpg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return 'application/octet-stream';
    }
  }

  Future<void> downloadAttachment(String url, String extension) async {
    isdownloading = true;

    _prepareSaveDir();

    final headers = {
      'Authorization': "Bearer ${Get.find<ApiClient>().token}",
      'content-type': _getContentType(extension),
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      await saveAndOpenFile(bytes, '${MyStrings.appName}_${DateTime.now().millisecondsSinceEpoch}.$extension', extension);
    } else {
      try {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      } catch (e) {
        CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
      }
    }
    selectedIndex = -1;
    isdownloading = false;
  }

  Future<void> saveAndOpenFile(List<int> bytes, String fileName, String extension) async {
    Directory? downloadsDirectory;

    if (Platform.isAndroid) {
      await Permission.storage.request();

      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    if (downloadsDirectory != null) {
      final downloadPath = '${downloadsDirectory.path}/$fileName';
      final file = File(downloadPath);
      await file.writeAsBytes(bytes);
      CustomSnackBar.success(successList: ['File saved at: $downloadPath']);
      // print('File saved at: $downloadPath');
      await openFile(downloadPath, extension);
    } else {
      CustomSnackBar.error(errorList: [MyStrings.downloadDirNotFound]);
    }
  }

  Future<void> openFile(String path, String extension) async {
    final file = File(path);
    if (await file.exists()) {
      final result = await OpenFile.open(path);
      if (result.type != ResultType.done) {
        if (result.type == ResultType.noAppToOpen) {
          CustomSnackBar.error(errorList: [MyStrings.noDocOpenerApp, 'File saved at: $path']);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.fileNotFound]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.screenBgColor,
      appBar: AppBar(
        surfaceTintColor: MyColor.transparentColor,
        backgroundColor: MyColor.primaryColor,
        title: Text(MyStrings.previewImage.tr, style: boldDefault.copyWith(color: MyColor.colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: MyColor.colorWhite),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          CircleIconButton(
            onTap: () {
              String extention = widget.url.split('.').last;
              if (isdownloading == false) {
                downloadAttachment(widget.url, extention);
              }
            },
            backgroundColor: MyColor.colorWhite.withOpacity(0.2),
            child: const Icon(Icons.download, color: MyColor.colorWhite),
          ),
          const SizedBox(width: Dimensions.space10)
        ],
      ),
      body: InteractiveViewer(
        child: Stack(
          children: [
            Opacity(
              opacity: isdownloading ? 0.3 : 1,
              child: CachedNetworkImage(
                imageUrl: widget.url.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    boxShadow: const [],
                    // borderRadius:  BorderRadius.circular(radius),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                    child: Center(
                      child: SpinKitFadingCube(
                        color: MyColor.primaryColor.withOpacity(0.3),
                        size: Dimensions.space20,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: MyColor.colorGrey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isdownloading) ...[
              const SpinKitFadingCircle(
                color: MyColor.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
