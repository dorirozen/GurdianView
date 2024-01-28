/// to add video
/*
import 'dart:async';
import 'dart:io';

import 'package:eduction_app/core/utils/constans.dart';
import 'package:eduction_app/core/utils/core_utils.dart';
import 'package:eduction_app/src/course/presention/cubit/course_cubit.dart';
import 'package:eduction_app/src/course/presention/cubit/course_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/titeld_input_field.dart';
import '../../../../core/services/injection_container.dart';
import '../../data/models/course_model.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({Key? key}) : super(key: key);

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? image;
  bool isFile = false;
  bool loading = false;
  /*
  Initialization Location:

Inside initState:
This is the most common and recommended place to add listeners to your controllers. initState is called only once when the widget is created. By adding listeners here, you ensure that they are set up as soon as the widget is initialized.
Example use case: Setting up a listener that updates a state or UI based on the text field's content as soon as the widget is displayed.
Outside initState:
You might choose to add a listener outside of initState if the setup of the listener depends on some condition or event that occurs after the widget initialization.
However, this is less common and should be approached with caution to avoid issues like adding the same listener multiple times or adding it at an inappropriate time in the widget lifecycle.
   */
  @override
  void initState() {
    super.initState();
    /*
    Purpose: You use addListener to attach a listener callback
     that gets called every time the text in the TextFormField
      changes. This is useful for scenarios where you want to
      perform an action whenever the text changes, like enabling
       a button when a field is not empty, validating the input
       on-the-fly, updating another part of the UI, etc.
     */
    imageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (isFile && imageController.text.trim().isEmpty) {
      image = null;
      isFile = false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    imageController.removeListener(_onTextChanged);
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseCubit, CubitState>(
      listener: (_, state) {
        debugPrint('${state.runtimeType}');
        if (state is CubitStateErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CubitStateAddingCourse) {
          loading = true;
          CoreUtils.showLoadingDialog(context);
        } else if (state is CubitStateCourseAdded) {
          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
          CoreUtils.showSnackBar(context, 'Course Added successfully');
          Navigator.pop(context);
          // TODO(Add-Course): send Notifications.
          //CoreUtils.showLoadingDialog(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Add Course',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TitledInputField(
                  controller: titleController,
                  title: 'Course Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                TitledInputField(
                  controller: desController,
                  title: 'Description',
                  required: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TitledInputField(
                  controller: imageController,
                  title: 'Course Image',
                  required: false,
                  hintText: 'Enter image URL or pick from gallery',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final image = await CoreUtils.pickImage();
                      if (image != null) {
                        isFile = true;
                        this.image = image;
                        //image file
                        final imageName = image.path.split('/').last;
                        imageController.text = imageName;
                      }
                    },
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final now = DateTime.now();
                            final course = CourseModel.empty().copyWith(
                              title: titleController.text.trim(),
                              des: desController.text.trim(),
                              image: imageController.text.trim().isEmpty
                                  ? kDefualtAvatar
                                  : isFile
                                      ? image!.path
                                      : imageController.text.trim(),
                              createdAt: now,
                              updateAt: now,
                              imageIsFile: isFile,
                            );
                            context.read<CourseCubit>().addCourse(course);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */
/// to move to another screen to see the alert in big screen
/*
import 'package:eduction_app/core/common/widgets/gradient_background.dart';
import 'package:eduction_app/core/common/widgets/nested_back_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/course_tile.dart';
import '../../../../core/resources/media_res.dart';
import '../../domain/entities/course_entity.dart';
import 'course_details.dart';

class AllCoursesView extends StatelessWidget {
  const AllCoursesView({Key? key, required this.courses}) : super(key: key);
  final List<Course> courses;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(leading: const NestedBackButton(), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
      ]),
      body: GradientBackGround(
        image: MediaRes.image2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'All subjects',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 40,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: courses
                      .map(
                        (course) => CourseTile(
                          course: course,
                          //arguments: course = to pass the course to the router to pass the details of it.
                          onTap: () => Navigator.of(context).pushNamed(
                              CourseDetailsScreen.routeName,
                              arguments: course),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

 */
///shows the details
/*
import 'package:eduction_app/core/common/widgets/gradient_background.dart';
import 'package:eduction_app/core/extensions/context_extensions.dart';
import 'package:eduction_app/core/extensions/int_extention.dart';
import 'package:eduction_app/core/resources/media_res.dart';
import 'package:eduction_app/src/course/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/course_info_tile.dart';
import '../../../../core/common/widgets/expandable_text.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);
  final Course course;
  static const routeName = 'course-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: GradientBackGround(
          image: MediaRes.image3,
          child: SafeArea(
              child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * .3,
                child: Center(
                  child: course.image != null
                      ? Image.network(course.image!)
                      : Image.asset(MediaRes.image1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (course.des != null)
                    ExpandableText(
                      context,
                      text: course.des!,
                    ),
                  if (course.numberOfMaterials > 0 ||
                      course.numberOfVideos > 0 ||
                      course.numberOfExams > 0) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Subjects Details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      CourseInfoTile(
                        image: MediaRes.image1,
                        title: '${course.numberOfVideos} Video(s)',
                        subTitle: 'Watch Our Tutorial videos',
                        // TODO: fix it after and change to videos..
                        onTap: () => Navigator.of(context)
                            .pushNamed('error', arguments: course),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      CourseInfoTile(
                        image: MediaRes.image1,
                        title: '${course.numberOfExams} Exam(s)',
                        subTitle: 'Watch Our Tutorial Exams',
                        // TODO: fix it after and change to Exams..
                        onTap: () => Navigator.of(context)
                            .pushNamed('error', arguments: course),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      CourseInfoTile(
                        image: MediaRes.image1,
                        title: '${course.numberOfMaterials} Material(s)',
                        subTitle:
                            'Access to ${course.numberOfMaterials.estimate} materials for ${course.title}',
                        // TODO: fix it after and change to Material..
                        onTap: () => Navigator.of(context)
                            .pushNamed('error', arguments: course),
                      ),
                    ],
                  ]
                ],
              ),
            ],
          ))),
    );
  }
}

 */
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/src/video/domain/entity/file_entity.dart';
import 'package:guardian_view/src/video/domain/entity/video_entity.dart';
import 'package:guardian_view/src/video/presention/cubit/video_cubit.dart';
import 'package:guardian_view/src/video/presention/cubit/video_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  File? selectedVideo;
  Uint8List? webImage;
  bool isUploading = false;
  double perc = 0;
  VideoFile? fileData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardian View'),
      ),
      body: BlocConsumer<VideoCubit, VideoState>(
        listener: (context, state) {
          if (state is VideoStateAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Video uploaded successfully!')),
            );
            setState(() {
              isUploading = false; // Reset the flag when upload is complete
            });
            context.read<VideoCubit>().close();
          }
          if (state is VideoStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<VideoCubit>().close();
            setState(() {
              isUploading = false; // Reset the flag in case of an error
            });
            debugPrint('state is VideoStateError');
          }
          if (state is VideoStateAdding) {
            setState(() {
              perc = state.progress.toDouble();
            });
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is VideoStateAdding) ...[
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    backgroundColor: Colors.black,
                    percent: (perc / 100),
                    progressColor: Colors.yellow,
                    center: Text(
                      '${perc.toStringAsFixed(1)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ],
                ElevatedButton(
                  onPressed: () => selectVideo(),
                  child: Text('Select Video'),
                ),
                ElevatedButton(
                  onPressed: (selectedVideo != null && !isUploading ||
                          webImage != null && !isUploading)
                      ? () => uploadVideo(context)
                      : null,
                  child: Text('Upload Video'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<VideoCubit>().close();
                    debugPrint('stream closed from button');
                  },
                  child: Text('cancel stream'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> selectVideo() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          selectedVideo = selected;
          webImage = null;
          isUploading = false;
        });
      } else {
        debugPrint('error picking image');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          selectedVideo = null;
          isUploading = false;
        });
      } else {
        debugPrint('error picking image');
      }
    } else {
      debugPrint('something went wrong');
    }
/*

    //final result = await FilePicker.platform.pickFiles(type: FileType.media);
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        //selectedVideo = File(result.files.single.path!);
        selectedVideo = File(result.path);
        isUploading = false;
      });
    }
 */
  }

  void uploadVideo(BuildContext context) {
    final videoData = VideoData(
      uid: 'YourUID', // Replace with actual data
      latitude: 0.0, // Replace with actual data
      longitude: 0.0, // Replace with actual data
      timestamp: DateTime.now(), // Replace with actual data
    );

    if (!kIsWeb && selectedVideo != null) {
      setState(() {
        fileData = VideoFile(file: selectedVideo);
      });
    } else if (kIsWeb) {
      setState(() {
        fileData = VideoFile(bytes: webImage);
      });
    }
    if (fileData != null) {
      if (selectedVideo != null || webImage != null) {
        setState(() {
          isUploading = true; // Set the flag when upload starts
        });
        context.read<VideoCubit>().addVideoDataUs(videoData, fileData!);
      }
    }
  }
}

///גרסא שנייה אבל לא סויימה
/*
class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AlertCubit>(),
      child: const UploadVideoPage(),
    );
  }
}

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  UploadTask? task;
  File? file;
  String? fileName; // Added to store the file name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              const SizedBox(height: 8),
              Text(
                fileName ?? 'No File Selected', // Display actual file name
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              BlocBuilder<AlertCubit, AlertState>(
                builder: (context, state) {
                  return ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: () => file == null
                        ? null
                        : () => context.read<AlertCubit>().addVideoDataUs(
                              VideoData(
                                uid: '1',
                                longitude: 0.0,
                                latitude: 0.7,
                                timestamp: DateTime.now(),
                              ),
                              file!,
                            ),
                  );
                },
              ),
              const SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
      fileName = result.files.single.name; // Set the file name
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}
 */
///גרסא ראשונית
/*
class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AlertCubit>(),
      child: const UploadVideoPage(),
    );
  }
}

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                'fileName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              BlocBuilder<AlertCubit, AlertState>(
                builder: (context, state) {
                  return ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: () => context.read<AlertCubit>().addVideoDataUs(
                        VideoData(
                            uid: '1',
                            longitude: 0.0,
                            latitude: 0.7,
                            timestamp: DateTime.now()),
                        file!),
                  );
                },
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}

 */
