import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Model/Products_model.dart';
import 'package:ecommerce/Widgets/String.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class Databaseservice {
  final _real = FirebaseDatabase.instance;
  final DatabaseReference _dbref = FirebaseDatabase.instance.ref();

 
  Future<List<Product>> getAllProducts() async {
    try {
      final DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child(AppStrings.chilCategory);

      final snapshot = await databaseRef.get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map;

        List<Product> allProducts = [];
        data.forEach((categoryKey, categoryData) {
          final categoryMap = Map<String, dynamic>.from(categoryData);
          if (categoryMap[AppStrings.chilpRODUCT] != null) {
            final productsMap =
                Map<String, dynamic>.from(categoryMap[AppStrings.chilpRODUCT]);
            productsMap.forEach((productKey, productData) {
              final productMap = Map<String, dynamic>.from(productData);
              allProducts.add(
                Product(
                  title: productMap['name'] ?? '',
                  price: productMap['price'] ?? 0.0,
                  description: productMap['description'] ?? '',
                  category: categoryMap['name'],
                  image: productMap['image'] ?? '',
                  barcode: productMap['barcode'],
                  stock: productMap['stock'],
                ),
              );
            });
          }
        });

        return allProducts;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching all products: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getProducts(String categoryKey) async {
    try {
      final DatabaseReference databaseRef = FirebaseDatabase.instance
          .ref()
          .child(AppStrings.chilCategory)
          .child(categoryKey)
          .child(AppStrings.chilpRODUCT);

      final snapshot = await databaseRef.get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map;
        return data.entries.map((e) {
          return {
            "key": e.key,
            ...Map<String, dynamic>.from(e.value),
          };
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final snapshot = await _dbref.child(AppStrings.chilCategory).get();
    if (snapshot.exists) {
      List<Map<String, dynamic>> categories = [];
      for (var category in snapshot.children) {
        final data = category.value as Map<dynamic, dynamic>;
        categories.add({
          "key": category.key,
          "name": data['name'],
          "products": data['products'] ?? {},
        });
      }
      return categories;
    } else {
      return [];
    }
  }

  void addCategory(String categoryName) {
    try {
      _real
          .ref("Categories")
          .push()
          .set({"name": categoryName, "products": {}});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateProduct(String categoryKey, String productKey, String productName,
      String price, int stock, String barCode) async {
    try {
      // Reference to the specific product using categoryKey and productKey
      final DatabaseReference productRef = _real
          .ref()
          .child(AppStrings.chilCategory) // Root categories node
          .child(categoryKey) // Specific category node
          .child("products") // Products node
          .child(productKey); // Unique product node

      // Update the product details
      await productRef.update({
        "name": productName,
        "price": price,
        "stock": stock,
        "barcode": barCode
      });

      print("Product updated successfully!");
    } catch (e) {
      print("Error updating product: ${e.toString()}");
    }
  }

  void updateCategory(String categoryKey, String newCategoryName) {
    try {
      _real
          .ref(AppStrings.chilCategory)
          .child(categoryKey)
          .update({"name": newCategoryName});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteCategory(String categoryKey) {
    try {
      _real.ref(AppStrings.chilCategory).child(categoryKey).remove();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteProduct(String categoryKey, String productKey) async {
    try {
      await _real
          .ref()
          .child(AppStrings.chilCategory)
          .child(categoryKey)
          .child("products")
          .child(productKey)
          .remove();

      print("Product deleted successfully!");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  void addProduct(String categoryKey, String productName, String price,
      int stock, String barCode, String desc) async {
    try {
      String productKey = _real
              .ref(AppStrings.chilCategory)
              .child(categoryKey)
              .child("products")
              .push()
              .key ??
          '';

      _real
          .ref()
          .child(AppStrings.chilCategory) // Root categories node
          .child(categoryKey) // Specific category node
          .child("products") // Products node
          .child(productKey) // Unique product node
          .set({
        "name": productName, // Product details
        "price": price,
        "stock": stock,
        "barcode": barCode,
        "description": desc,
      });
      print("Product added successfully!");
    } catch (e) {
      print(e.toString());
    }
  }
}
