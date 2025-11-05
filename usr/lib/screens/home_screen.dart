import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Product> products = [
    Product(
      id: '1',
      name: 'MacBook Pro 16"',
      category: 'Laptops',
      price: 2499.99,
      image: '💻',
      description: 'Powerful laptop for professionals',
    ),
    Product(
      id: '2',
      name: 'Dell XPS 15',
      category: 'Laptops',
      price: 1899.99,
      image: '💻',
      description: 'Premium Windows laptop',
    ),
    Product(
      id: '3',
      name: 'iPhone 15 Pro',
      category: 'Smartphones',
      price: 999.99,
      image: '📱',
      description: 'Latest flagship smartphone',
    ),
    Product(
      id: '4',
      name: 'Samsung Galaxy S24',
      category: 'Smartphones',
      price: 899.99,
      image: '📱',
      description: 'Android powerhouse',
    ),
    Product(
      id: '5',
      name: 'iPad Pro 12.9"',
      category: 'Tablets',
      price: 1099.99,
      image: '📱',
      description: 'Professional tablet',
    ),
    Product(
      id: '6',
      name: 'Sony WH-1000XM5',
      category: 'Headphones',
      price: 399.99,
      image: '🎧',
      description: 'Premium noise-canceling headphones',
    ),
    Product(
      id: '7',
      name: 'LG 4K Monitor 27"',
      category: 'Monitors',
      price: 449.99,
      image: '🖥️',
      description: 'Ultra HD display',
    ),
    Product(
      id: '8',
      name: 'Logitech MX Master 3',
      category: 'Accessories',
      price: 99.99,
      image: '🖱️',
      description: 'Ergonomic wireless mouse',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer),
            onPressed: () {
              Navigator.pushNamed(context, '/deals');
            },
            tooltip: 'View Deals',
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Hero Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium Electronics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover the latest in technology',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/deals');
                      },
                      icon: const Icon(Icons.local_fire_department),
                      label: const Text('Hot Deals'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Products Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: ProductCard(product: products[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
