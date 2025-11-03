import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Use Material 3 design and a seed color for a modern theme
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        // Define a consistent Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          clipBehavior: Clip.antiAlias, // Clips the content (like images) to the card's shape
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade700,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProductCatalog(),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl; // Will use real image URLs
  final Color color; // Kept for card backgrounds/accents if needed

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.color,
  });
}

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  // Use a mutable list to allow for removing items with Dismissible
  late List<Product> products;

  // Static list of categories for the GridView.count
  final List<Map<String, dynamic>> categories = [
    {'name': 'Electronics', 'icon': Icons.devices, 'color': Colors.blue.shade100},
    {'name': 'Apparel', 'icon': Icons.checkroom, 'color': Colors.green.shade100},
    {'name': 'Office', 'icon': Icons.work, 'color': Colors.orange.shade100},
    {'name': 'Home', 'icon': Icons.home, 'color': Colors.yellow.shade100},
    {'name': 'Outdoors', 'icon': Icons.park, 'color': Colors.brown.shade100},
    {'name': 'Fitness', 'icon': Icons.fitness_center, 'color': Colors.red.shade100},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the product list
    products = [
      Product(
        id: '1',
        name: 'Wireless Headphones',
        description:
        'Noise cancelling wireless headphones with premium sound quality',
        price: 199.99,
        // Using picsum.photos for real placeholders
        imageUrl: 'https://picsum.photos/seed/headphones/400/400',
        color: Colors.blue.shade100,
      ),
      Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Fitness tracker with heart rate monitor and GPS',
        price: 299.99,
        imageUrl: 'https://picsum.photos/seed/watch/400/400',
        color: Colors.green.shade100,
      ),
      Product(
        id: '3',
        name: 'Laptop Stand',
        description: 'Adjustable aluminum laptop stand for ergonomic computing',
        price: 89.99,
        imageUrl: 'https://picsum.photos/seed/laptop/400/400',
        color: Colors.orange.shade100,
      ),
      Product(
        id: '4',
        name: 'Desk Lamp',
        description:
        'LED desk lamp with adjustable brightness and color temperature',
        price: 49.99,
        imageUrl: 'https://picsum.photos/seed/lamp/400/400',
        color: Colors.yellow.shade100,
      ),
      Product(
        id: '5',
        name: 'Water Bottle',
        description:
        'Insulated stainless steel water bottle, keeps drinks cold for 24 hours',
        price: 34.99,
        imageUrl: 'https://picsum.photos/seed/bottle/400/400',
        color: Colors.blue.shade50,
      ),
      Product(
        id: '6',
        name: 'Backpack',
        description:
        'Water-resistant backpack with laptop compartment and multiple pockets',
        price: 79.99,
        imageUrl: 'https://picsum.photos/seed/backpack/400/400',
        color: Colors.brown.shade100,
      ),
      Product(
        id: '7',
        name: 'Phone Case',
        description:
        'Protective phone case with drop protection and wireless charging support',
        price: 24.99,
        imageUrl: 'https://picsum.photos/seed/case/400/400',
        color: Colors.purple.shade100,
      ),
      Product(
        id: '8',
        name: 'Keyboard',
        description: 'Mechanical keyboard with RGB lighting and programmable keys',
        price: 129.99,
        imageUrl: 'https://picsum.photos/seed/keyboard/400/400',
        color: Colors.grey.shade200,
      ),
    ];
  }

  bool _isGridView = true;
  final ScrollController _scrollController = ScrollController();

  // Function to remove item for the Dismissible
  void _removeItem(String id) {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed'),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ## SliverAppBar ##
          // A large, collapsible app bar for a modern look.
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            floating: false,
            // Title shown when collapsed
            title: const Text('Product Catalog'),
            // Content for the expanded app bar
            flexibleSpace: FlexibleSpaceBar(
              // Title shown when expanded
              title: const Text(
                'Discover',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: false,
              titlePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              // ## Stack ##
              // Used to layer the image and a gradient overlay
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://picsum.photos/seed/store/1200/800',
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header for "Featured" section with the view toggle button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                    tooltip: _isGridView ? 'Show List' : 'Show Grid',
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // ## ListView ##
          // A horizontal ListView.builder for the "Featured" items
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 4, // Show first 4 items as featured
                itemBuilder: (context, index) {
                  final product = products[index];
                  // ## Card ##
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.imageUrl,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Header for "All Products" section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                'All Products',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ## SliverSafeArea ##
          // Ensures the main content list/grid avoids notches
          SliverSafeArea(
            top: false, // AppBar already handled top
            sliver: _isGridView
                ?
            // ## SliverGrid ##
            // Uses SliverGridDelegateWithMaxCrossAxisExtent (GridView.extent)
            // and SliverChildBuilderDelegate (GridView.builder)
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0, // This is GridView.extent
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                // This is the builder part (GridView.builder)
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = products[index];
                    // ## Card ## & ## Stack ##
                    return _buildGridCard(context, product);
                  },
                  childCount: products.length,
                ),
              ),
            )
                :
            // ## SliverList ##
            // Uses SliverChildBuilderDelegate (ListView.builder)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = products[index];
                  // ## Dismissible ##, ## Card ##, & ## ListTile ##
                  return _buildListCard(context, product);
                },
                childCount: products.length,
              ),
            ),
          ),

          // Header for "Categories"
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ## GridView.count ##
          // Embedded inside a SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true, // Required inside SliverToBoxAdapter
                physics:
                const NeverScrollableScrollPhysics(), // Parent handles scroll
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: categories.map((category) {
                  return Card(
                    color: category['color'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'],
                            size: 32,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 8),
                        Text(
                          category['name'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Add some final padding at the bottom
          const SliverToBoxAdapter(
            child: SizedBox(height: 80), // Space for FAB
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll back to the top
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  // Helper widget for building the Grid Card
  Widget _buildGridCard(BuildContext context, Product product) {
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product.imageUrl,
                  height: 120,
                  fit: BoxFit.cover,
                  // Loading builder for better UX
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 120,
                      color: product.color,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Favorite Icon using Positioned inside the Stack
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              color: Colors.white.withOpacity(0.8),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.3),
              ),
              onPressed: () {
                // Handle favorite
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for building the List Card with Dismissible
  Widget _buildListCard(BuildContext context, Product product) {
    return Dismissible(
      // ## Dismissible ##
      key: Key(product.id), // Unique key is required
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeItem(product.id);
      },
      // Background shown when swiping
      background: Container(
        color: Colors.red.shade700,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child:
        // ## ListTile ##
        ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            product.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            '\$${product.price}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onTap: () {
            // Handle product tap
          },
        ),
      ),
    );
  }
}