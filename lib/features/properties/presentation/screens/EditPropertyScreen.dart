// lib/features/properties/presentation/screens/edit_property_screen.dart
import 'package:flutter/material.dart';

class EditPropertyScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  // Form State
  String _selectedType = '';
  String _propertyName = '';
  String _rentPrice = '';
  String _deposit = '';
  String _bedrooms = '';
  String _bathrooms = '';
  String _kitchens = '';
  String _livingRooms = '';
  String _houseSize = '';
  String _floorNumber = '';
  String _unitCode = '';
  String _numberOfFloors = '';
  String _roomName = '';
  String _roomSize = '';
  String _description = '';
  String _fullAddress = '';

  // Location
  String _selectedRegion = '';
  String _selectedDistrict = '';
  String _selectedVillage = '';

  // Toggles
  bool _parkingAvailable = false;
  bool _isMasterRoom = false;
  bool _isSaving = false;
  bool _isDeleting = false;

  // Images
  final List<String> _images = [];

  // Amenities
  final List<String> _selectedAmenities = [];
  final List<Map<String, String>> _amenities = [
    {'id': '1', 'name': 'WiFi', 'icon': '📶'},
    {'id': '2', 'name': 'AC', 'icon': '❄️'},
    {'id': '3', 'name': 'Heating', 'icon': '🔥'},
    {'id': '4', 'name': 'Furnished', 'icon': '🛋️'},
    {'id': '5', 'name': 'Security', 'icon': '👮'},
    {'id': '6', 'name': 'Laundry', 'icon': '🧺'},
  ];

  // Property Types
  final List<Map<String, String>> _propertyTypes = [
    {'id': '1', 'name': 'apartment', 'label': 'Apartment'},
    {'id': '2', 'name': 'villa', 'label': 'Villa'},
    {'id': '3', 'name': 'floor', 'label': 'Floor'},
    {'id': '4', 'name': 'room', 'label': 'Room'},
  ];

  // Regions, Districts, Villages
  final List<Map<String, String>> _regions = [
    {'id': '1', 'name': 'Banaadir'},
    {'id': '2', 'name': 'Hiran'},
    {'id': '3', 'name': 'Lower Shabelle'},
  ];

  final List<Map<String, String>> _districts = [];
  final List<Map<String, String>> _villages = [];

  @override
  void initState() {
    super.initState();
    _loadPropertyData();
  }

  void _loadPropertyData() {
    // Load property data from widget
    final property = widget.property;

    // Parse property type from the data
    String propertyType = property['type'] ?? 'Apartment';
    if (propertyType == 'Apartment') {
      _selectedType = 'Apartment';
    } else if (propertyType == 'Villa') {
      _selectedType = 'Villa';
    } else if (propertyType == 'Floor') {
      _selectedType = 'Floor';
    } else if (propertyType == 'Room') {
      _selectedType = 'Room';
    }

    // Load other data
    _propertyName = property['title'] ?? '';
    _rentPrice = (property['rent'] ?? 0).toString();
    _bedrooms = (property['bedrooms'] ?? 0).toString();
    _bathrooms = (property['bathrooms'] ?? 0).toString();
    _houseSize = property['size'] ?? '';
    _description = 'This is a sample description for ${property['title']}';
    _fullAddress = property['location'] ?? '';

    // Set location (assuming location format is "Region, District")
    final locationParts = property['location']?.split(',') ?? [];
    if (locationParts.isNotEmpty) {
      _selectedRegion = locationParts[0].trim();
      if (locationParts.length > 1) {
        _selectedDistrict = locationParts[1].trim();
      }
    }

    // Load images
    _images.add(property['image'] ?? '');

    // Load amenities (sample)
    _selectedAmenities.addAll(['1', '3', '5']); // WiFi, Heating, Security

    // Load parking status
    _parkingAvailable = true; // Sample

    // Initialize districts based on region
    if (_selectedRegion == 'Banaadir') {
      _districts.addAll([
        {'id': '1', 'name': 'Hodan'},
        {'id': '2', 'name': 'Hawlwadag'},
        {'id': '3', 'name': 'Warta Nabada'},
      ]);
    }

    // Initialize villages based on district
    if (_selectedDistrict.isNotEmpty) {
      _villages.addAll([
        {'id': '1', 'name': 'Village 1'},
        {'id': '2', 'name': 'Village 2'},
        {'id': '3', 'name': 'Village 3'},
      ]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Type
            _buildDropdown(
              label: 'Property Type',
              value: _selectedType,
              items: _propertyTypes.map((type) => type['label']!).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                  // Reset specific fields when type changes
                  _propertyName = '';
                  _roomName = '';
                  _floorNumber = '';
                  _unitCode = '';
                  _numberOfFloors = '';
                });
              },
              hint: 'Select type',
            ),
            const SizedBox(height: 16),

            // Only show form if type is selected
            if (_selectedType.isNotEmpty) ...[
              // Property Name (not for Room)
              if (_selectedType != 'Room') ...[
                _buildTextField(
                  label: _selectedType == 'Apartment'
                      ? 'Apartment Name'
                      : 'Property Title',
                  hint: 'eg, Dahab tower',
                  value: _propertyName,
                  onChanged: (value) => setState(() => _propertyName = value),
                ),
                const SizedBox(height: 16),
              ],

              // Room Name (only for Room)
              if (_selectedType == 'Room') ...[
                _buildTextField(
                  label: 'Room Name or Room Code',
                  hint: 'eg, Room 101',
                  value: _roomName,
                  onChanged: (value) => setState(() => _roomName = value),
                ),
                const SizedBox(height: 16),
              ],

              // Floor Number (Apartment only)
              if (_selectedType == 'Apartment') ...[
                _buildTextField(
                  label: 'Floor Number',
                  hint: 'eg, 3rd Floor',
                  value: _floorNumber,
                  onChanged: (value) => setState(() => _floorNumber = value),
                ),
                const SizedBox(height: 16),
              ],

              // Unit Code (Apartment only)
              if (_selectedType == 'Apartment') ...[
                _buildTextField(
                  label: 'Unit Code',
                  hint: 'eg, A-301',
                  value: _unitCode,
                  onChanged: (value) => setState(() => _unitCode = value),
                ),
                const SizedBox(height: 16),
              ],

              // Number of Floors (Floor only)
              if (_selectedType == 'Floor') ...[
                _buildTextField(
                  label: 'Number of Floors',
                  hint: '0',
                  value: _numberOfFloors,
                  onChanged: (value) => setState(() => _numberOfFloors = value),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
              ],

              // Is Master Room (Room only)
              if (_selectedType == 'Room') ...[
                _buildToggleSwitch(
                  label: 'Is Master Room',
                  value: _isMasterRoom,
                  onChanged: (value) => setState(() => _isMasterRoom = value),
                  icon: '👑',
                ),
                const SizedBox(height: 16),
              ],

              // Rent Price & Deposit
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Rent price (\$/month)',
                      hint: '0',
                      value: _rentPrice,
                      onChanged: (value) => setState(() => _rentPrice = value),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: 'Deposit (optional)',
                      hint: '0',
                      value: _deposit,
                      onChanged: (value) => setState(() => _deposit = value),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bedrooms & Bathrooms
              Row(
                children: [
                  if (_selectedType != 'Room') ...[
                    Expanded(
                      child: _buildTextField(
                        label: 'Bedrooms',
                        hint: '0',
                        value: _bedrooms,
                        onChanged: (value) => setState(() => _bedrooms = value),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: _buildTextField(
                      label: _selectedType == 'Room'
                          ? 'Bathroom Count'
                          : 'Bathrooms',
                      hint: '0',
                      value: _bathrooms,
                      onChanged: (value) => setState(() => _bathrooms = value),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Kitchens & Living Rooms (not for Room)
              if (_selectedType != 'Room') ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Kitchens',
                        hint: '0',
                        value: _kitchens,
                        onChanged: (value) => setState(() => _kitchens = value),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        label: 'Living rooms',
                        hint: '0',
                        value: _livingRooms,
                        onChanged: (value) =>
                            setState(() => _livingRooms = value),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // House Size (not for Room)
              if (_selectedType != 'Room') ...[
                _buildTextField(
                  label: 'House Size (optional)',
                  hint: 'Enter house size',
                  value: _houseSize,
                  onChanged: (value) => setState(() => _houseSize = value),
                ),
                const SizedBox(height: 16),
              ],

              // Room Size (Room only)
              if (_selectedType == 'Room') ...[
                _buildTextField(
                  label: 'Room Size (optional)',
                  hint: 'Enter room size',
                  value: _roomSize,
                  onChanged: (value) => setState(() => _roomSize = value),
                ),
                const SizedBox(height: 16),
              ],

              // Location Section
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // Region
              _buildDropdown(
                label: 'Region',
                value: _selectedRegion,
                items: _regions.map((region) => region['name']!).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value!;
                    _selectedDistrict = '';
                    _selectedVillage = '';
                    _districts.clear();
                    _villages.clear();

                    // Load sample districts
                    if (_selectedRegion == 'Banaadir') {
                      _districts.addAll([
                        {'id': '1', 'name': 'Hodan'},
                        {'id': '2', 'name': 'Hawlwadag'},
                        {'id': '3', 'name': 'Warta Nabada'},
                      ]);
                    }
                  });
                },
                hint: 'Select region',
              ),
              const SizedBox(height: 12),

              // District
              _buildDropdown(
                label: 'District',
                value: _selectedDistrict,
                items: _districts.map((district) => district['name']!).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value!;
                    _selectedVillage = '';
                    _villages.clear();

                    // Load sample villages
                    if (_selectedDistrict.isNotEmpty) {
                      _villages.addAll([
                        {'id': '1', 'name': 'Village 1'},
                        {'id': '2', 'name': 'Village 2'},
                        {'id': '3', 'name': 'Village 3'},
                      ]);
                    }
                  });
                },
                hint: 'Select district',
                enabled: _selectedRegion.isNotEmpty,
              ),
              const SizedBox(height: 12),

              // Village
              _buildDropdown(
                label: 'Village',
                value: _selectedVillage,
                items: _villages.map((village) => village['name']!).toList(),
                onChanged: (value) => setState(() => _selectedVillage = value!),
                hint: _villages.isEmpty
                    ? 'No villages available'
                    : 'Select village',
                enabled: _selectedDistrict.isNotEmpty && _villages.isNotEmpty,
              ),
              const SizedBox(height: 12),

              // Full Address
              _buildTextField(
                label: 'Full Address (optional)',
                hint: 'Enter full address',
                value: _fullAddress,
                onChanged: (value) => setState(() => _fullAddress = value),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: TextEditingController(text: _description),
                  onChanged: (value) => setState(() => _description = value),
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Describe your property....',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Property Images
              const Text(
                'Property Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),

              _images.isEmpty
                  ? _buildImageUploadPlaceholder()
                  : _buildImageGrid(),
              const SizedBox(height: 16),

              // Parking Switch
              _buildToggleSwitch(
                label: 'Parking Available',
                value: _parkingAvailable,
                onChanged: (value) => setState(() => _parkingAvailable = value),
                icon: '🚗',
              ),
              const SizedBox(height: 16),

              // Amenities
              const Text(
                'Amenities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Column(
                children: _amenities.map((amenity) {
                  return _buildAmenityToggle(
                    name: amenity['name']!,
                    icon: amenity['icon']!,
                    isSelected: _selectedAmenities.contains(amenity['id']),
                    onToggle: () {
                      setState(() {
                        if (_selectedAmenities.contains(amenity['id']!)) {
                          _selectedAmenities.remove(amenity['id']!);
                        } else {
                          _selectedAmenities.add(amenity['id']!);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          _isSaving || _isDeleting ? null : _deleteProperty,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isDeleting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.red,
                              ),
                            )
                          : const Text('Delete'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _isSaving || _isDeleting ? null : _updateProperty,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Update'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  // ========== HELPER WIDGETS ==========

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hint,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.isEmpty ? null : value,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    hint,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
                ...items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ],
              onChanged: enabled ? onChanged : null,
              isExpanded: true,
              hint: Text(hint),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required String value,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: TextEditingController(text: value),
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSwitch({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    String icon = '',
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF22C55E),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadPlaceholder() {
    return GestureDetector(
      onTap: () {
        // Simulate image upload
        setState(() {
          _images.addAll([
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
            'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
          ]);
        });
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              'Tap to add photos',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(_images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _images.removeAt(index);
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            // Add more images
            setState(() {
              _images.add(
                  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800');
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add More Photos'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF22C55E),
            side: const BorderSide(color: Color(0xFF22C55E)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmenityToggle({
    required String name,
    required String icon,
    required bool isSelected,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Switch(
            value: isSelected,
            onChanged: (value) => onToggle(),
            activeColor: const Color(0xFF22C55E),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      title: const Text(
        'Edit Property',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.save_as_outlined, color: Colors.black),
          onPressed: _isSaving ? null : _updateProperty,
        ),
      ],
    );
  }

  void _updateProperty() {
    // Validation
    if (_selectedType.isEmpty) {
      _showError('Please select a property type');
      return;
    }

    if (_selectedType != 'Room' && _propertyName.isEmpty) {
      _showError('Please enter property name');
      return;
    }

    if (_selectedType == 'Room' && _roomName.isEmpty) {
      _showError('Please enter room name');
      return;
    }

    if (_rentPrice.isEmpty) {
      _showError('Please enter rent price');
      return;
    }

    if (_selectedRegion.isEmpty ||
        _selectedDistrict.isEmpty ||
        _selectedVillage.isEmpty) {
      _showError('Please complete the location fields');
      return;
    }

    setState(() => _isSaving = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isSaving = false);
      _showSuccess('Property updated successfully!');
      Navigator.pop(context);
    });
  }

  Future<void> _deleteProperty() async {
    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Property'),
        content: const Text(
            'Are you sure you want to delete this property? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isDeleting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isDeleting = false);

    _showSuccess('Property deleted successfully!');

    // Navigate back to properties screen
    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
