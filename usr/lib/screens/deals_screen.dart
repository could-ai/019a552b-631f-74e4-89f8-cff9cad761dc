import 'package:flutter/material.dart';
import '../widgets/deal_card.dart';
import '../models/deal.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _listAnimation;

  final List<Deal> deals = [
    Deal(
      id: '1',
      productName: 'MacBook Air M2',
      originalPrice: 1199.99,
      discountedPrice: 999.99,
      discountPercentage: 17,
      image: '💻',
      description: 'Lightweight powerhouse',
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Deal(
      id: '2',
      productName: 'Samsung Galaxy Tab S9',
      originalPrice: 799.99,
      discountedPrice: 599.99,
      discountPercentage: 25,
      image: '📱',
      description: 'Premium Android tablet',
      endDate: DateTime.now().add(const Duration(days: 5)),
    ),
    Deal(
      id: '3',
      productName: 'Sony WH-1000XM5',
      originalPrice: 399.99,
      discountedPrice: 299.99,
      discountPercentage: 25,
      image: '🎧',
      description: 'Best noise canceling',
      endDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Deal(
      id: '4',
      productName: 'ASUS ROG Gaming Laptop',
      originalPrice: 1899.99,
      discountedPrice: 1499.99,
      discountPercentage: 21,
      image: '💻',
      description: 'RTX 4070 Graphics',
      endDate: DateTime.now().add(const Duration(days: 7)),
    ),
    Deal(
      id: '5',
      productName: 'Apple Watch Series 9',
      originalPrice: 429.99,
      discountedPrice: 349.99,
      discountPercentage: 19,
      image: '⌚',
      description: 'Advanced health features',
      endDate: DateTime.now().add(const Duration(days: 4)),
    ),
    Deal(
      id: '6',
      productName: 'Dell UltraSharp 32" 4K',
      originalPrice: 699.99,
      discountedPrice: 499.99,
      discountPercentage: 29,
      image: '🖥️',
      description: 'Professional monitor',
      endDate: DateTime.now().add(const Duration(days: 6)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _listAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'HORIZON',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'by FORZA',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Animated Header
          AnimatedBuilder(
            animation: _headerAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _headerAnimation.value,
                child: Opacity(
                  opacity: _headerAnimation.value,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade600, Colors.red.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Hot Deals',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Limited time offers - Save up to 29%!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Deals List
          Expanded(
            child: AnimatedBuilder(
              animation: _listAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _listAnimation.value,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: deals.length,
                    itemBuilder: (context, index) {
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 400 + (index * 100)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(50 * (1 - value), 0),
                            child: Opacity(
                              opacity: value,
                              child: DealCard(deal: deals[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
