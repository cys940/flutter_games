import 'package:flutter/material.dart';

/// 디바이스의 화면 크기에 따른 반응형 레이아웃을 지원하는 유틸리티 클래스입니다.
class ResponsiveLayout extends StatelessWidget {

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  /// 현재 화면이 모바일인지 확인합니다.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  /// 현재 화면이 태블릿인지 확인합니다.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  /// 현재 화면이 데스크탑인지 확인합니다.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200 && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= 600 && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
