import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameMarketScreen extends StatefulWidget {
  final Function(String)? onSelectBackground;
  final Function(String)? onSelectCharacter;
  final ValueNotifier<String> selectedCharacter;

  const GameMarketScreen({
    Key? key,
    this.onSelectBackground,
    this.onSelectCharacter,
    required this.selectedCharacter, required selectedBackground,
  }) : super(key: key);

  @override
  _GameMarketScreenState createState() => _GameMarketScreenState();
}

class _GameMarketScreenState extends State<GameMarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<GameProduct> products = [
    GameProduct(
      name: 'Default',
      price: 2.99,
      image: 'backGrounds/background_Default.jpg',
      category: 'Background',
    ),
    GameProduct(
      name: 'Desert',
      price: 4.99,
      image: 'backGrounds/background_Desert.jpg',
      category: 'Background',
    ),
    GameProduct(
      name: 'Grass',
      price: 9.99,
      image: 'backGrounds/background_Grass.jpg',
      category: 'Background',
    ),
    GameProduct(
      name: 'Autumn',
      price: 9.99,
      image: 'backGrounds/background_Autumn.jpg',
      category: 'Background',
    ),
    GameProduct(
      name: 'Autumn',
      price: 9.99,
      image: 'characters/character_Autumn.jpg',
      category: 'Characters',
    ),
    GameProduct(
      name: 'Grass',
      price: 9.99,
      image: 'characters/character_Grass.jpg',
      category: 'Characters',
    ),
    GameProduct(
      name: 'Default',
      price: 9.99,
      image: 'characters/character_Default.jpg',
      category: 'Characters',
    ),
  ];

  List<int> purchasedProducts = [];
  int? equippedProductIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? purchasedProductsStringList =
    prefs.getStringList('purchasedProducts');
    if (purchasedProductsStringList != null) {
      purchasedProducts =
          purchasedProductsStringList.map((e) => int.parse(e)).toList();
    }

    int? loadedEquippedProductIndex = prefs.getInt('equippedProductIndex');
    if (loadedEquippedProductIndex != null &&
        loadedEquippedProductIndex >= 0 &&
        loadedEquippedProductIndex < products.length) {
      equippedProductIndex = loadedEquippedProductIndex;
    }

    setState(() {});
  }

  Future<bool> onWillPop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('equippedProductIndex', equippedProductIndex ?? -1);

    String selectedBackground = equippedProductIndex != null &&
        products[equippedProductIndex!].category == 'Background'
        ? 'background_${products[equippedProductIndex!].name}.jpg'
        : '';
    String selectedCharacter = equippedProductIndex != null &&
        products[equippedProductIndex!].category == 'Characters'
        ? 'character_${products[equippedProductIndex!].name}.jpg'
        : '';

    // Navigator.pop ile geri döndürülen değeri değiştir
    Navigator.pop(context, {
      'selectedBackground': selectedBackground,
      'selectedCharacter': selectedCharacter,
    });

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Market'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Background'),
              Tab(text: 'Characters'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildTabContent(products
                .where((product) => product.category == 'Background')
                .toList()),
            buildTabContent(products
                .where((product) => product.category == 'Characters')
                .toList()),
          ],
        ),
      ),
    );
  }

  Widget buildTabContent(List<GameProduct> tabProducts) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GridView.builder(
        shrinkWrap: false,
        padding: const EdgeInsets.all(2.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 1.3,
        ),
        itemCount: tabProducts.length,
        itemBuilder: (context, index) {
          return GameProductCard(
            product: tabProducts[index],
            onPurchase: () {
              setState(() {
                purchasedProducts.add(index);
                if (equippedProductIndex == null) {
                  equippedProductIndex = index;
                }
              });

              savePreferences();
            },
            onEquip: () {
              setState(() {
                equippedProductIndex = index;
              });

              savePreferences();
            },
            onUnequip: () {
              setState(() {
                equippedProductIndex = null;
              });

              savePreferences();
            },
            onSelect: () {
              if (tabProducts[index].category == 'Background') {
                widget.onSelectBackground?.call(tabProducts[index].image);
              } else if (tabProducts[index].category == 'Characters') {
                widget.onSelectCharacter?.call(tabProducts[index].image);
              }
            },
            isPurchased: purchasedProducts.contains(index),
            isEquipped: equippedProductIndex == index,
          );
        },
      ),
    );
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'purchasedProducts', purchasedProducts.map((e) => e.toString()).toList());
    prefs.setInt('equippedProductIndex', equippedProductIndex ?? -1);
  }
}

class GameProductCard extends StatelessWidget {
  final GameProduct product;
  final VoidCallback? onPurchase;
  final VoidCallback? onEquip;
  final VoidCallback? onUnequip;
  final VoidCallback? onSelect;
  final bool isPurchased;
  final bool isEquipped;

  const GameProductCard({
    Key? key,
    required this.product,
    this.onPurchase,
    this.onEquip,
    this.onUnequip,
    this.onSelect,
    required this.isPurchased,
    required this.isEquipped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              'assets/${product.image}',
              width: double.infinity,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(product.name),
              subtitle: Text(
                'Price: \$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: isPurchased ? Colors.green : Colors.red,
                ),
              ),
              trailing: isPurchased
                  ? ElevatedButton(
                onPressed: () {
                  if (isEquipped) {
                    onUnequip?.call();
                  } else {
                    onEquip?.call();
                  }
                  onSelect?.call();
                },
                child: Text(isEquipped ? 'Unequip' : 'Equip'),
              )
                  : ElevatedButton(
                onPressed: onPurchase,
                child: const Text('Buy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameProduct {
  final String name;
  final double price;
  final String image;
  final String category;

  GameProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}
