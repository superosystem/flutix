part of 'shared.dart';

Future<File> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  var image = await _picker.pickImage(source: ImageSource.gallery);

  return File(image!.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}
