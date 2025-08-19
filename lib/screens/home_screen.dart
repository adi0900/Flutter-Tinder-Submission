import 'package:flutter/material.dart';
import '../models/user.dart';
import '../constants/colors.dart';
import '../widgets/swipeable_stack.dart';
import 'match_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SwipeableStackState> _swipeableStackKey = 
      GlobalKey<SwipeableStackState>();
  
  String _selectedTab = 'For You';

  List<User> users = [
    User(
      id: '1',
      name: 'Emma',
      age: 24,
      bio: 'Love hiking and good coffee ☕',
      profileImage: 'assets/images/profiles/emma.jpg',
      interests: ['Travel', 'Photography', 'Yoga'],
    ),
    User(
      id: '2',
      name: 'Sophie',
      age: 26,
      bio: 'Artist and dog lover 🎨🐕',
      profileImage: 'assets/images/profiles/sophie.jpg',
      interests: ['Art', 'Music', 'Dogs'],
    ),
    User(
      id: '3',
      name: 'Maya',
      age: 23,
      bio: 'Foodie exploring the city 🍕',
      profileImage: 'assets/images/profiles/maya.jpg',
      interests: ['Cooking', 'Travel', 'Netflix'],
    ),
    User(
      id: '4',
      name: 'Olivia',
      age: 27,
      bio: 'Fitness enthusiast & bookworm 📚',
      profileImage: 'assets/images/profiles/olivia.jpg',
      interests: ['Fitness', 'Reading', 'Hiking'],
    ),
    User(
      id: '5',
      name: 'Zoe',
      age: 25,
      bio: 'Weekend adventurer ⛰️',
      profileImage: 'assets/images/profiles/zoe.jpg',
      interests: ['Adventure', 'Camping', 'Photography'],
    ),
  ];

  void _onSwipe(User user, bool isLiked) {
    if (isLiked && _shouldMatch()) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MatchScreen(matchedUser: user),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  bool _shouldMatch() {
    return DateTime.now().millisecond % 3 == 0;
  }

  void _programmaticSwipe(bool isLiked, {bool isSuperLike = false}) {
    if (_swipeableStackKey.currentState != null) {
      _swipeableStackKey.currentState!.programmaticSwipe(isLiked, isSuperLike);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSectionSelector(),
              Expanded(
                child: users.isNotEmpty
                    ? SwipeableStack(
                        key: _swipeableStackKey,
                        users: users,
                        onSwipe: _onSwipe,
                      )
                    : const Center(
                        child: Text(
                          'No more profiles',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
              ),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.person_outline,
              color: AppColors.maroon,
              size: 24,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.accent,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Dating',
                  style: TextStyle(
                    color: AppColors.maroon,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.maroon,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.15),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('Nearby', Icons.location_on_outlined),
          ),
          Expanded(
            child: _buildTabButton('For You', Icons.favorite_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon) {
    bool isSelected = _selectedTab == title;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              _selectedTab = title;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.tabGradient : null,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.maroon : AppColors.textGray,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? AppColors.maroon : AppColors.textGray,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.close,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB3BA), Color(0xFFFF8A95)],
            ),
            onTap: () => _programmaticSwipe(false),
            size: 55,
          ),
          _buildActionButton(
            icon: Icons.star,
            gradient: const LinearGradient(
              colors: [Color(0xFFBAE1FF), Color(0xFF8AC5FF)],
            ),
            onTap: () => _programmaticSwipe(true, isSuperLike: true),
            size: 65,
          ),
          _buildActionButton(
            icon: Icons.favorite,
            gradient: const LinearGradient(
              colors: [Color(0xFFBAFFC9), Color(0xFF8AFF9B)],
            ),
            onTap: () => _programmaticSwipe(true),
            size: 55,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
    double size = 60,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}