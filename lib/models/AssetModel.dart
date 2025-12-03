class Asset{
  final String id;
  final String title;
  final String category;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final String serialNumber;
  final String userId;
  final num price;
  final DateTime createdAt;

  Asset({required this.id, required this.title, required this.category, required this.purchaseDate, required this.expiryDate, required this.serialNumber, required this.userId, required this.price, required this.createdAt});


}
 const AssetCategories = [
   "Electronics",  "Appliances", "Furniture", "Document"
 ];