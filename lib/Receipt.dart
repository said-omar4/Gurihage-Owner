import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// U maleynaaya inaad faylkaan (receipt_data.dart) sameysay
import 'receipt_data.dart';
import 'package:dotted_border/dotted_border.dart';

// Ku daroo Xirfadsan Logo asagoo ah image asset
// const String xirfadsanLogoAsset = 'assets/xirfadsan-logo.png'; // U hubso inuu ku jiro pubspec.yaml
const String xirfadsanLogoAsset = 'assets/xirfadsan-logo.jpg';

//==============================================================================
// Widgets Yar Yar
//==============================================================================

/// Logo-ga Xirfadsan
class XirfadsanLogo extends StatelessWidget {
  final double size;
  const XirfadsanLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      xirfadsanLogoAsset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

/// Safka Xogta Rasiidka (Label iyo Value)
class ReceiptRow extends StatelessWidget {
  final String label;
  final Widget value;
  final bool isTotal;
  final bool hasDivider;

  const ReceiptRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.hasDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isTotal ? 16.0 : 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: isTotal
                    ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: Color(0xFF6B7280)), // text-muted-foreground
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DefaultTextStyle(
                    textAlign: TextAlign.right,
                    style: isTotal
                        ? GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color:
                                const Color(0xFFF97316), // text-primary orange
                          )
                        : GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                    child: value,
                  ),
                ),
              ),
            ],
          ),
          if (hasDivider)
            const DashedDivider(
                color: Color(0xFFE5E7EB), padding: EdgeInsets.only(top: 16.0)),
        ],
      ),
    );
  }
}

/// Divider-ka Khadka Go'go'an ah
class DashedDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashSpace;
  final EdgeInsets padding;

  const DashedDivider({
    super.key,
    this.color = const Color(0xFF6B7280),
    this.thickness = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: thickness,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

/// Badge-ka (Tusaale: AC Cooling ama Mobile Money)
class ReceiptBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const ReceiptBadge.orange({super.key, required this.text})
      : backgroundColor = const Color(0xFFFFF7ED), // Orange 50
        textColor = const Color(0xFFF97316); // Orange 600

  const ReceiptBadge.gray({super.key, required this.text})
      : backgroundColor = const Color(0xFFF3F4F6), // Gray 100
        textColor = const Color(0xFF374151); // Gray 700

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Batoonada waaweyn ee hoose (Download iyo Share)
class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color primaryColor;
  final Color splashColor;
  final bool isLoading;

  const ActionButton.download({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  })  : icon = Icons.download,
        primaryColor = const Color(0xFFF97316), // Orange
        splashColor = const Color(0xFFFFCC80); // Lighter Orange

  const ActionButton.share({
    super.key,
    required this.text,
    required this.onPressed,
  })  : icon = Icons.share,
        primaryColor = const Color(0xFFFCD34D), // Yellow
        splashColor = const Color(0xFFFFECB3), // Lighter Yellow
        isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool isDownload = icon == Icons.download;
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(12.0),
        splashColor: splashColor,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                Icon(
                  icon,
                  color: isDownload ? Colors.white : Colors.black,
                  size: 24,
                ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: isDownload ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// Qaybta Muhiimka ah (Main Components)
//==============================================================================

/// Kaarka Muujinaya Rasiidka
class ReceiptCard extends StatelessWidget {
  final ReceiptData data;

  const ReceiptCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(symbol: r'$', decimalDigits: 2);
    final addressLines = data.address.split(',').map((s) => s.trim()).toList();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4), // Shadow-ga React
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Logo-ga
          const XirfadsanLogo(size: 100),
          const SizedBox(height: 16.0),

          // 2. Invoice Number Box
          // Column(
          //   children: [
          //     const Text(
          //       "Invoice",
          //       style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          //     ),
          //     const SizedBox(height: 8.0),
          //     Container(
          //       padding: const EdgeInsets.symmetric(
          //           horizontal: 16.0, vertical: 12.0),
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //             color: Colors.black, style: BorderStyle.dashed, width: 2),
          //         borderRadius: BorderRadius.circular(8.0),
          //       ),
          //       child: Text(
          //         data.invoiceNumber,
          //         style: GoogleFonts.spaceMono(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //           letterSpacing: 1.5,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          Column(
            children: [
              const Text(
                "Invoice",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 8.0),

              // 🛑 KAN WAXAA LAGU BEDDELAY DOTTEBBORDER 🛑
              DottedBorder(
                color: Colors.black, // Midabka khadka
                strokeWidth:
                    2, // Balaadhka khadka (wuxuu la mid yahay 'width: 2' kii hore)
                dashPattern: const [
                  8,
                  4
                ], // Tani waxay abuurtaa go'go'a (8 pixels khad, 4 pixels bannaan)
                borderType:
                    BorderType.RRect, // Nooca border-ka (Rect oo wareegsan)
                radius: const Radius.circular(
                    8), // Wareega geesaska (wuxuu la mid yahay kii hore)

                // 'Container'-kan waa inuu weli jiraa si loo hayo padding-ka gudaha
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  // Halkan ma jirto Decoration sababtoo ah DottedBorder ayaa border-ka samaynaya
                  child: Text(
                    data.invoiceNumber,
                    style: GoogleFonts.spaceMono(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 3. Faahfaahinta Macmiilka
          const DashedDivider(color: Color(0xFFE5E7EB)),
          ReceiptRow(label: "Customer Name", value: Text(data.customerName)),
          ReceiptRow(label: "Phone number", value: Text(data.phoneNumber)),
          ReceiptRow(label: "Invoice number", value: Text(data.invoiceCode)),
          ReceiptRow(label: "Booking date", value: Text(data.bookingDate)),
          ReceiptRow(
              label: "Completion time", value: Text(data.completionTime)),
          ReceiptRow(
            label: "Address",
            value: Text(
              addressLines.join('\n'),
              textAlign: TextAlign.right,
            ),
          ),

          // 4. Faahfaahinta Adeegga
          const DashedDivider(color: Color(0xFFE5E7EB)),
          ReceiptRow(
              label: "Category",
              value: ReceiptBadge.orange(text: data.category)),
          ReceiptRow(label: "Sub-services", value: Text(data.subServices)),
          ReceiptRow(label: "Technician", value: Text(data.technician)),
          ReceiptRow(label: "Service ID", value: Text(data.serviceId)),

          // 5. Faahfaahinta Lacagta
          const DashedDivider(color: Color(0xFFE5E7EB)),
          ReceiptRow(
              label: "Service Cost",
              value: Text(formatCurrency.format(data.serviceCost))),
          ReceiptRow(
              label: "Government Tax",
              value: Text(formatCurrency.format(data.governmentTax))),
          ReceiptRow(
              label: "Payment Method",
              value: ReceiptBadge.gray(text: data.paymentMethod)),

          // 6. Grand Total
          ReceiptRow(
            label: "Grand Total",
            value: Text(formatCurrency.format(data.grandTotal)),
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

//==============================================================================
// Page-ka Guud
//==============================================================================

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  bool _isDownloading = false;

  void _handleDownloadPDF() {
    setState(() {
      _isDownloading = true;
    });

    // Halkan ku darso Logic-ga Download-ka PDF-ka
    // Maadaama uusan Flutter code si toos ah ula mid aheyn React's window.print()
    // Waxaad u baahan doontaa inaad isticmaasho packages sida:
    // 1. pdf (si loo abuuro PDF file)
    // 2. path_provider (si loo kaydiyo)
    // 3. share_plus (si loo wadaago)

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
        // Tusaale ahaan Toast-ka / Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF Ready for download!')),
        );
      }
    });
  }

  void _handleShare() async {
    // Halkan ku darso Logic-ga Wadaagista (Sharing)
    // Waxaad u baahan doontaa package-ka `share_plus` ama `url_launcher`
    // Tusaale:
    // await Share.share('Receipt from Xirfadsan. Total: \$${ReceiptData.mockData.grandTotal.toStringAsFixed(2)}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receipt link copied to clipboard.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // bg-background (Gray 100)
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Kaarka Rasiidka
                ReceiptCard(data: ReceiptData.mockData),

                // 2. Batoonada
                const SizedBox(height: 24.0),
                ActionButton.download(
                  text: _isDownloading ? "Preparing PDF..." : "Download PDF",
                  onPressed: _handleDownloadPDF,
                  isLoading: _isDownloading,
                ),
                const SizedBox(height: 12.0),
                ActionButton.share(
                  text: "Share Reciept",
                  onPressed: _handleShare,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//==============================================================================
// Sawirka Labaad (PDF View)
//==============================================================================

// Sawirka labaad (Receipt Latter pdf.jpg) wuxuu u muuqdaa nuqul la daabacayo ama loo diyaarinayo PDF.
// Waxay u egtahay Kaarka Rasiidka (ReceiptCard) oo kaliya, laakiin leh geeska hoose ee go'go'an (zigzag).
// Si taas loo sameeyo, waxaad u baahan doontaa `CustomClipper`

class PDFReceiptCard extends StatelessWidget {
  final ReceiptData data;

  const PDFReceiptCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Isticmaal ReceiptCard-ka, laakiin ku duub ClipPath
    return ClipPath(
      clipper: PDFReceiptClipper(),
      child: ReceiptCard(data: data),
    );
  }
}

// Clipper-ka Abuuraya Qaabka Go'go'an ee hoose
class PDFReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double zigzagHeight = 10.0;
    const double waveSize = 10.0;

    // Bilow xagga sare (Standard rectangle)
    path.lineTo(0, size.height - zigzagHeight);

    // Abuur qaybta go'go'an (Zigzag)
    for (double i = 0; i < size.width; i += waveSize * 2) {
      path.lineTo(i + waveSize, size.height - zigzagHeight - waveSize);
      path.lineTo(i + waveSize * 2, size.height - zigzagHeight);
    }

    // Xir path-ka
    path.lineTo(size.width, size.height - zigzagHeight);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(PDFReceiptClipper oldClipper) => false;
}
