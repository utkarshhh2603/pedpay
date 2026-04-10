import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart';

class PlantListing {
  final String name;
  final String species;
  final String age;
  final String location;
  final double credits;
  final double price;
  final String imageUrl;

  PlantListing({
    required this.name,
    required this.species,
    required this.age,
    required this.location,
    required this.credits,
    required this.price,
    required this.imageUrl,
  });
}

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final List<String> _filters = ['All Plants', 'Mangroves', 'Teak', 'Bamboo', 'Other Species'];
  String _selectedFilter = 'All Plants';

  final List<PlantListing> _plantListings = [
    PlantListing(
        name: "Red Mangrove", species: "Rhizophora mangle", age: "3 years", location: "Sundarbans, Bangladesh", credits: 12.5, price: 187.50, imageUrl: "https://picsum.photos/600/200?random=1"),
    PlantListing(
        name: "Black Mangrove", species: "Avicennia germinans", age: "4 years", location: "Florida Everglades, USA", credits: 15.2, price: 228.00, imageUrl: "https://picsum.photos/600/200?random=2"),
    PlantListing(
        name: "White Mangrove", species: "Laguncularia racemosa", age: "2.5 years", location: "Amazon Delta, Brazil", credits: 9.8, price: 147.00, imageUrl: "https://picsum.photos/600/200?random=3"),
    PlantListing(
        name: "Teak Plantation", species: "Tectona grandis", age: "5 years", location: "Central Java, Indonesia", credits: 22.3, price: 334.50, imageUrl: "https://picsum.photos/600/200?random=4"),
    PlantListing(
        name: "Bamboo Grove", species: "Bambusa vulgaris", age: "1.5 years", location: "Chiang Mai, Thailand", credits: 7.6, price: 114.00, imageUrl: "https://picsum.photos/600/200?random=5"),
    PlantListing(
        name: "Coconut Palm", species: "Cocos nucifera", age: "4 years", location: "Kerala, India", credits: 11.2, price: 168.00, imageUrl: "https://picsum.photos/600/200?random=6"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMarketplaceHeader(),
          _buildFilters(),
          _buildPlantsGrid(),
        ],
      ),
    );
  }

  Widget _buildMarketplaceHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Carbon Credit Marketplace',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, color: AppColors.darkerGreen, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            'Browse and purchase verified carbon credits from sustainable projects around the world',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: _filters.map((filter) {
          bool isSelected = _selectedFilter == filter;
          return ActionChip(
            label: Text(filter),
            backgroundColor: isSelected ? AppColors.primaryGreen : AppColors.pastelGreen,
            labelStyle: TextStyle(color: isSelected ? AppColors.darkerGreen : AppColors.textDark),
            onPressed: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlantsGrid() {
    // In a real app, you would filter _plantListings here based on _selectedFilter
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row for mobile/tablet
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.65, // Adjust for card content height
        ),
        itemCount: _plantListings.length,
        itemBuilder: (context, index) {
          return _PlantCard(listing: _plantListings[index]);
        },
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  final PlantListing listing;

  const _PlantCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              listing.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listing.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
                const SizedBox(height: 5),
                Text('Species: ${listing.species}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                Text('Age: ${listing.age}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.mapMarkerAlt, size: 12, color: AppColors.textLight),
                    const SizedBox(width: 5),
                    Flexible(child: Text(listing.location, style: const TextStyle(fontSize: 12, color: AppColors.textLight))),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${listing.credits} Credits', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkerGreen)),
                    Text('\$${listing.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkerGreen)),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added ${listing.name} credits to cart!')),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.shoppingCart, size: 16),
                  label: const Text('Buy Credits', style: TextStyle(fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.darkerGreen,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}