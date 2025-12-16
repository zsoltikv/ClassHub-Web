import 'package:flutter/material.dart';
import 'group_details_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> with TickerProviderStateMixin {
  int? hoveredIndex;

  final List<Map<String, dynamic>> groups = [
    {
      "name": "Matematika",
      "icon": Icons.calculate_rounded,
      "color": Color(0xFF6366F1),
      "members": 28,
    },
    {
      "name": "Fizika",
      "icon": Icons.science_rounded,
      "color": Color(0xFF8B5CF6),
      "members": 25,
    },
    {
      "name": "Informatika",
      "icon": Icons.computer_rounded,
      "color": Color(0xFF06B6D4),
      "members": 32,
    },
    {
      "name": "Biológia",
      "icon": Icons.biotech_rounded,
      "color": Color(0xFF10B981),
      "members": 27,
    },
    {
      "name": "Kémia",
      "icon": Icons.science_outlined,
      "color": Color(0xFFF59E0B),
      "members": 24,
    },
    {
      "name": "Történelem",
      "icon": Icons.auto_stories_rounded,
      "color": Color(0xFFEF4444),
      "members": 29,
    },
  ];

  Widget buildGroupCard(int index) {
    final group = groups[index];
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final isHovered = hoveredIndex == index && isDesktop;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: MouseRegion(
              onEnter: (_) => setState(() => hoveredIndex = index),
              onExit: (_) => setState(() => hoveredIndex = null),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: isHovered ? 1.03 : 1.0),
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                GroupDetailPage(groupName: group["name"]),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(isHovered ? 0.12 : 0.08),
                              Colors.white.withOpacity(isHovered ? 0.08 : 0.04),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(
                              isHovered ? 0.2 : 0.1,
                            ),
                            width: 1,
                          ),
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color: group["color"].withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    offset: Offset(0, 10),
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Positioned(
                                top: -50,
                                right: -50,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        group["color"].withOpacity(0.15),
                                        group["color"].withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            group["color"].withOpacity(0.8),
                                            group["color"].withOpacity(0.6),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: group["color"].withOpacity(
                                              0.4,
                                            ),
                                            blurRadius: 15,
                                            spreadRadius: 0,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        group["icon"],
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      group["name"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white.withOpacity(0.95),
                                        letterSpacing: 0.3,
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.people_rounded,
                                                size: 14,
                                                color: Colors.white.withOpacity(
                                                  0.7,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${group["members"]}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (isHovered)
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.15,
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                0.3,
                                              ),
                                              width: 1,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            size: 16,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 3;

    if (screenWidth < 600) {
      crossAxisCount = 1;
    } else if (screenWidth < 1000) {
      crossAxisCount = 2;
    } else if (screenWidth < 1400) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0A0A), Color(0xFF121212)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Csoportok",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(0.95),
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Válaszd ki a csoportodat",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return buildGroupCard(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}