import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/base_widget.dart';
import 'package:guardian_view/res_try/responsive/orientation_layout.dart';
import 'package:guardian_view/res_try/responsive/screen_type_layout.dart';
import 'package:guardian_view/res_try/views/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';
import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeViewRoot extends StatelessWidget {
  const HomeViewRoot({super.key});

  @override
  Widget build(BuildContext context) {
    /// How BaseWidget Helps in HomeViewRoot ?
    /// 1.It abstracts the boilerplate of setting up a ChangeNotifierProvider for the view model (HomeViewModel).
    /// 2.Provides a structured way to initialize the view model state (initialize method).
    /// 3.It makes the view model (HomeViewModel) readily available to all widgets within the child function's scope.
    /// 4.Enhances code readability and maintainability by encapsulating the provider setup and view model initialization logic.
    /// במקום להעביר את המידע לכל אחד בנפרד , יצרנו אחד כללי!.

/*
/// my version
return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..initialize(),
      builder: (context, _) => ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => HomeMobilePortrait(),
          landscape: (context) => HomeMobileLandscape(),
        ),
        tablet: HomeViewTablet(),
      ),
    );
  }
}

 */
    /// his version
    return BaseWidget<HomeViewModel>(
      create: HomeViewModel(),
      initilizeState: (model) => model.initialize(),
      child: (context) => ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => HomeMobilePortrait(),
          landscape: (context) => HomeMobileLandscape(),
        ),
        tablet: HomeViewTablet(),
      ),
    );
  }
}
