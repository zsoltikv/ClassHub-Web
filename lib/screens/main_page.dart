import 'package:flutter/material.dart';
import 'groups_page.dart';
import 'messages_page.dart';
import 'profile_page.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with TickerProviderStateMixin {
  Widget selectedPage = const GroupsPage();
  int selectedIndex = 0;
  late AnimationController _hoverController;
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  Widget buildDesktopNavItem(
    IconData icon,
    String label,
    VoidCallback onTap,
    int index,
  ) {
    final isSelected = selectedIndex == index;
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.15)
              : (isHovered
                    ? Colors.white.withOpacity(0.08)
                    : Colors.transparent),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: isHovered ? 1.15 : 1.0),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Icon(
                        icon,
                        size: 28,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.7),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  child: Text(label, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMobileNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1 * value),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 26,
            color: Color.lerp(
              Colors.white.withOpacity(0.6),
              Colors.white,
              value,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: isDesktop
          ? Row(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF1A1A1A),
                        const Color(0xFF0F0F0F),
                      ],
                    ),
                    border: Border(
                      right: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.05),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.school,
                              color: Colors.white.withOpacity(0.9),
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "ClassHub",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      buildDesktopNavItem(Icons.group_rounded, "Csoportok", () {
                        setState(() {
                          selectedPage = const GroupsPage();
                          selectedIndex = 0;
                        });
                      }, 0),
                      buildDesktopNavItem(
                        Icons.message_rounded,
                        "Üzenetek",
                        () {
                          setState(() {
                            selectedPage = const MessagesPage();
                            selectedIndex = 1;
                          });
                        },
                        1,
                      ),
                      buildDesktopNavItem(
                        Icons.event_rounded,
                        "Osztálykirándulás",
                        () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        2,
                      ),
                      const Spacer(),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildDesktopNavItem(Icons.person_rounded, "Profil", () {
                        setState(() {
                          selectedPage = const ProfilePage();
                          selectedIndex = 3;
                        });
                      }, 3),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.02, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey(selectedIndex),
                      child: selectedPage,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Container(
                      key: ValueKey(selectedIndex),
                      child: selectedPage,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF1A1A1A),
                        const Color(0xFF0F0F0F),
                      ],
                    ),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPage = const GroupsPage();
                              selectedIndex = 0;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: buildMobileNavItem(Icons.group_rounded, 0),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPage = const MessagesPage();
                              selectedIndex = 1;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: buildMobileNavItem(Icons.message_rounded, 1),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: buildMobileNavItem(Icons.event_rounded, 2),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPage = const ProfilePage();
                              selectedIndex = 3;
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: buildMobileNavItem(Icons.person_rounded, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}