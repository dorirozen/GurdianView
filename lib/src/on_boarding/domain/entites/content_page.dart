import 'package:equatable/equatable.dart';
import 'package:guardian_view/core/resources/media_res.dart';

class ContentPage extends Equatable {
  const ContentPage(
      {required this.image, required this.title, required this.des});
  final String image;
  final String title;
  final String des;

  const ContentPage.first()
      : this(
            image: MediaRes.vector2,
            des: 'here is image1',
            title: 'Brand new curriculum');

  const ContentPage.second()
      : this(image: MediaRes.vector1, des: 'here is image2', title: 'image2');

  const ContentPage.third()
      : this(image: MediaRes.vector2, des: 'here is image3', title: 'image3');

  @override
  List<Object?> get props => [image, title, des];
}
