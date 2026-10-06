import 'package:flutter/material.dart';
import 'package:kaciru_desu/widgets/food_card.dart';

import '../models/food.dart';

class FoodsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("F O O D S", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.food_bank_rounded,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 50,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "H O M E",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.food_bank_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "F O O D S",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "K A S I R",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/kasir');
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "H I S T O R I",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/histori');
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle_sharp,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "P R O F I L",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 75),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "L O G O U T",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          String selectedCategory = 'Semua';
          String searchQuery = '';

          final filteredFoods = foods.where((food) {
            final matchCategory =
                selectedCategory == 'Semua' ||
                food.kategoriMakanan == selectedCategory;

            final matchSearch = food.namaMakanan.toLowerCase().contains(
              searchQuery.toLowerCase(),
            );

            return matchCategory && matchSearch;
          }).toList();

          return Column(
            children: [
              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari makanan atau minuman...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),

              // KATEGORI
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: ['Semua', 'Makanan', 'Minuman'].map((category) {
                    final isSelected = selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 8),

              // CARD MAKANAN / MINUMAN
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: filteredFoods.length,
                  itemBuilder: (context, index) {
                    final food = filteredFoods[index];

                    return FoodCard(food: food);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
