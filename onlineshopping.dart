// Dart program for an online shopping cart system

import 'dart:io';

// --- Standard Function with Optional Parameters ---
/// Calculates the total cost of items, optionally applying a tax rate.
///
/// [prices]: A list of item prices.
/// [taxRate]: The tax percentage to apply (e.g., 0.05 for 5%). Defaults to 0.0.
double calculateTotal(List<double> prices, [double taxRate = 0.0]) {
  double subtotal = prices.reduce((a, b) => a + b);
  double taxAmount = subtotal * taxRate;
  return subtotal + taxAmount;
}

// --- Higher-Order Function ---
/// Applies a discount to a list of prices using a provided discount function.
///
/// [prices]: The list of original prices.
/// [discountFunction]: A function that takes a price (double) and returns the discounted price (double).
List<double> applyDiscount(List<double> prices, double Function(double) discountFunction) {
  // map() is a higher-order function that takes the anonymous discountFunction
  return prices.map(discountFunction).toList();
}

// --- Recursive Function ---
/// Recursively calculates the factorial of a number.
/// Used here to determine a special factorial discount.
///
/// [n]: The number to calculate the factorial of.
/// Returns n!
int calculateFactorial(int n) {
  if (n <= 1) {
    return 1;
  }
  // Recursive step: n * (n-1)!
  return n * calculateFactorial(n - 1);
}

// --- Main Program Logic ---
void main() {
  // 1. Initial Data
  print('🛒 Initializing Shopping Cart...');
  List<double> cartPrices = [5.50, 12.00, 8.75, 25.00, 4.99, 50.00];
  const double standardDiscountRate = 0.10; // 10%
  const double salesTaxRate = 0.05; // 5%
  final int itemCount = cartPrices.length;

  print('Original Item Prices: \$${cartPrices.join(', \$')}');
  print('Total Items: $itemCount\n');

  // --- 2. Anonymous Function Example: Filtering Low-Cost Items ---
  // The anonymous function (price) => price >= 10.0 is passed to where()
  List<double> filteredPrices = cartPrices.where((price) => price >= 10.0).toList();
  print('--- Filtering Items (Price >= \$10) ---');
  print('Filtered Items: \$${filteredPrices.join(', \$')}');

  // We'll proceed with the original list for the main calculation
  List<double> currentPrices = List.from(cartPrices);
  print('Proceeding with all ${currentPrices.length} items.\n');


  // --- 3. Higher-Order Function Example: Applying Standard Discount ---

  // Define the anonymous discount function to be passed to applyDiscount
  // This function returns the price reduced by the standardDiscountRate.
  double fixedDiscount(double price) => price * (1.0 - standardDiscountRate);

  print('--- Applying Standard Discount ($standardDiscountRate% Off) ---');
  currentPrices = applyDiscount(currentPrices, fixedDiscount);

  print('Prices After 10% Discount: \$${currentPrices.map((p) => p.toStringAsFixed(2)).join(', \$')}');

  // --- 4. Final Calculation (Subtotal and Tax) ---
  double totalBeforeSpecialDiscount = calculateTotal(currentPrices, salesTaxRate);

  print('\n--- Calculating Total Price ---');
  print('Tax Rate: ${(salesTaxRate * 100).toStringAsFixed(0)}%');
  print('Total After Standard Discount & Tax: \$${totalBeforeSpecialDiscount.toStringAsFixed(2)}');


  // --- 5. Recursive Function Example: Applying Special Factorial Discount ---
  int factorial = calculateFactorial(itemCount); // Factorial of number of items
  // Ensure the discount is a reasonable percentage (e.g., cap it)
  // We'll use the factorial for a special discount: Factorial % off
  // Example: 6 items = 720! -> Too big. Let's use 4 items for example: 4! = 24
  double specialDiscountRate = factorial.toDouble() / 100.0;
  
  if (specialDiscountRate > 50) { // Safety cap for the discount percentage
    specialDiscountRate = 50.0; 
  }

  print('\n--- Applying Special Recursive Discount ---');
  print('Items in Cart: $itemCount');
  print('Factorial of Item Count ($itemCount!): $factorial');
  print('Special Discount Applied: ${specialDiscountRate.toStringAsFixed(2)}% Off');
  
  // Calculate final price after special discount
  double finalPrice = totalBeforeSpecialDiscount * (1.0 - (specialDiscountRate / 100.0));

  print('Final Price After Special Discount: \$${finalPrice.toStringAsFixed(2)}');
  print('\n✅ Transaction Complete.');
}