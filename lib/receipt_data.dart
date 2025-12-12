/// Xogta rasiidka oo ah model Dart ah
class ReceiptData {
  final String invoiceNumber;
  final String customerName;
  final String phoneNumber;
  final String invoiceCode;
  final String bookingDate;
  final String completionTime;
  final String address;
  final String category;
  final String subServices;
  final String technician;
  final String serviceId;
  final double serviceCost;
  final double governmentTax;
  final String paymentMethod;
  final double grandTotal;

  ReceiptData({
    required this.invoiceNumber,
    required this.customerName,
    required this.phoneNumber,
    required this.invoiceCode,
    required this.bookingDate,
    required this.completionTime,
    required this.address,
    required this.category,
    required this.subServices,
    required this.technician,
    required this.serviceId,
    required this.serviceCost,
    required this.governmentTax,
    required this.paymentMethod,
  }) : grandTotal = serviceCost + governmentTax;

  // Xogta la isticmaalayo
  static ReceiptData mockData = ReceiptData(
    invoiceNumber: "0237-7746-8981-9028-5626",
    customerName: "Victor Shoaga",
    phoneNumber: "+252 612346678",
    invoiceCode: "XRF-2025-00847",
    bookingDate: "Dec 12, 2025",
    completionTime: "2:30 PM",
    address: "Banaadir, hoadan, Mogadishu, Somalia",
    category: "AC Cooling",
    subServices: "Mukeef Dhaqitaan",
    technician: "Maxamed Abdi",
    serviceId: "SRV-AC-478229",
    serviceCost: 45.0,
    governmentTax: 4.5,
    paymentMethod: "Mobile Money",
  );
}
