import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;


  CustomPageRoute( {
    required this.child,
  }) : super(
          transitionDuration: Duration(seconds: 1),
          reverseTransitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );
}

class CustomPageRouteLR extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;


  CustomPageRouteLR({
    required this.child, required this.direction, RouteSettings? settings,
  }) : super(
          transitionDuration: Duration(seconds: 1),
          reverseTransitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset(){
    switch(direction){
      case AxisDirection.up:
        return Offset(0, 1);
        case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
        case AxisDirection.left:
        return Offset(1, 0);
    }
  }


}




class RotationRoute extends PageRouteBuilder {
  final Widget child;
  RotationRoute({required this.child})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        RotationTransition(
          turns: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            ),
          ),
          child: child,
        ),
  );
}




class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    reverseTransitionDuration: Duration(seconds: 1),
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        ),
  );
}



class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,transitionDuration: Duration(seconds: 1),reverseTransitionDuration: Duration(seconds: 1),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}




class ScaleRotateRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRotateRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
            ),
            child: child,
          ),
        ),
  );
}





class ScalePageRouteLR extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;


  ScalePageRouteLR({
    required this.child, required this.direction, RouteSettings? settings,
  }) : super(
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: getBeginOffset(),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );


  Offset getBeginOffset(){
    switch(direction){
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }


}




class FadePageRouteLR extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;


  FadePageRouteLR({
    required this.child, required this.direction, RouteSettings? settings,
  }) : super(
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>

      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child:
        FadeTransition(
          opacity: animation,
          child: child,
        ),
      );


  Offset getBeginOffset(){
    switch(direction){
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }


}




class FadeScalePageRoute extends PageRouteBuilder {
  final Widget child;


  FadeScalePageRoute( {
    required this.child,
  }) : super(
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}





class ScaleFadePageRouteLR extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;


  ScaleFadePageRouteLR({
    required this.child, required this.direction, RouteSettings? settings,
  }) : super(
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>

      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child:
        ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        )
      );


  Offset getBeginOffset(){
    switch(direction){
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }


}

