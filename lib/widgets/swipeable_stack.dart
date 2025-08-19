import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/profile_card.dart';

class SwipeableStack extends StatefulWidget {
  final List<User> users;
  final Function(User user, bool isLiked) onSwipe;

  const SwipeableStack({
    Key? key,
    required this.users,
    required this.onSwipe,
  }) : super(key: key);

  @override
  State<SwipeableStack> createState() => SwipeableStackState();
}

class SwipeableStackState extends State<SwipeableStack>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;
  
  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
    _scaleAnimationController.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    const threshold = 80.0;
    final velocity = details.velocity.pixelsPerSecond;
    
    if (_dragOffset.dx.abs() > threshold || velocity.dx.abs() > 800) {
      bool isLiked = _dragOffset.dx > 0 || velocity.dx > 0;
      _swipeCard(isLiked);
    } else {
      _resetCard();
    }
  }

  void _resetCard() {
    setState(() {
      _dragOffset = Offset.zero;
      _isDragging = false;
    });
    _scaleAnimationController.reverse();
  }

  void programmaticSwipe(bool isLiked, [bool isSuperLike = false]) {
    if (_currentIndex < widget.users.length && !_animationController.isAnimating) {
      _dragOffset = Offset(isLiked ? 200 : -200, isSuperLike ? -50 : 0);
      _swipeCard(isLiked);
    }
  }

  void _swipeCard(bool isLiked) {
    if (_currentIndex < widget.users.length) {
      widget.onSwipe(widget.users[_currentIndex], isLiked);
      
      final screenWidth = MediaQuery.of(context).size.width;
      final currentOffset = _dragOffset / screenWidth;
      final endOffset = Offset(isLiked ? 2.0 : -2.0, currentOffset.dy * 0.3);
      
      _slideAnimation = Tween<Offset>(
        begin: currentOffset,
        end: endOffset,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
      
      _rotationAnimation = Tween<double>(
        begin: _dragOffset.dx / screenWidth * 0.3,
        end: isLiked ? 0.4 : -0.4,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
      
      _animationController.forward().then((_) {
        if (mounted) {
          setState(() {
            _currentIndex++;
            _dragOffset = Offset.zero;
            _isDragging = false;
          });
          _animationController.reset();
          _scaleAnimationController.reset();
          if (_currentIndex < widget.users.length) {
            _scaleAnimationController.forward();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.users.length) {
      return const Center(
        child: Text(
          'No more profiles',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Stack(
      children: [
        if (_currentIndex + 1 < widget.users.length)
          Transform.scale(
            scale: 0.92,
            child: Opacity(
              opacity: 0.8,
              child: ProfileCard(user: widget.users[_currentIndex + 1]),
            ),
          ),
        
        GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: AnimatedBuilder(
            animation: Listenable.merge([_animationController, _scaleAnimationController]),
            builder: (context, child) {
              Offset currentOffset = _animationController.isAnimating
                  ? _slideAnimation.value * MediaQuery.of(context).size.width
                  : _dragOffset;
              
              double rotation = _animationController.isAnimating
                  ? _rotationAnimation.value
                  : currentOffset.dx / MediaQuery.of(context).size.width * 0.3;
              
              double opacity = _animationController.isAnimating
                  ? _opacityAnimation.value
                  : 1.0;
              
              return Transform.translate(
                offset: currentOffset,
                child: Transform.rotate(
                  angle: rotation,
                  child: Opacity(
                    opacity: opacity,
                    child: ProfileCard(user: widget.users[_currentIndex]),
                  ),
                ),
              );
            },
          ),
        ),
        
        if (_isDragging && _dragOffset.dx.abs() > 30)
          Positioned(
            top: 60,
            left: _dragOffset.dx > 0 ? null : 30,
            right: _dragOffset.dx > 0 ? 30 : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: _dragOffset.dx > 0
                    ? const LinearGradient(
                        colors: [Color(0xFFBAFFC9), Color(0xFF8AFF9B)],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFFFB3BA), Color(0xFFFF8A95)],
                      ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: (_dragOffset.dx > 0 
                        ? const Color(0xFF8AFF9B) 
                        : const Color(0xFFFF8A95)).withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _dragOffset.dx > 0 ? Icons.favorite : Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _dragOffset.dx > 0 ? 'LIKE' : 'NOPE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}