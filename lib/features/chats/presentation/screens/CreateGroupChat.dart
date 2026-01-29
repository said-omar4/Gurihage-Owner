// lib/features/chats/presentation/screens/create_group_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/core/theme/app_theme.dart';

// ============================================
// TENANT MODEL (INSIDE SCREEN FILE)
// ============================================
class Tenant {
  final String id;
  final String userId;
  final String fullName;
  final String? email;
  final String? avatarUrl;
  bool isSelected;

  Tenant({
    required this.id,
    required this.userId,
    required this.fullName,
    this.email,
    this.avatarUrl,
    this.isSelected = false,
  });
}

// ============================================
// CREATE GROUP CHAT SCREEN
// ============================================
class CreateGroupChatScreen extends StatefulWidget {
  const CreateGroupChatScreen({super.key});

  @override
  State<CreateGroupChatScreen> createState() => _CreateGroupChatScreenState();
}

class _CreateGroupChatScreenState extends State<CreateGroupChatScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isCreating = false;
  String? _groupNameError;

  // Sample tenants data
  final List<Tenant> _tenants = [
    Tenant(
      id: '1',
      userId: 'user_101',
      fullName: 'Killam James',
      email: 'killam@example.com',
      avatarUrl: null,
    ),
    Tenant(
      id: '2',
      userId: 'user_102',
      fullName: 'John Smith',
      email: 'john@example.com',
      avatarUrl: null,
    ),
    Tenant(
      id: '3',
      userId: 'user_103',
      fullName: 'Sarah Johnson',
      email: 'sarah@example.com',
      avatarUrl: null,
    ),
    Tenant(
      id: '4',
      userId: 'user_104',
      fullName: 'Ahmed Mohamed',
      email: 'ahmed@example.com',
      avatarUrl: null,
    ),
    Tenant(
      id: '5',
      userId: 'user_105',
      fullName: 'Fatima Hassan',
      email: 'fatima@example.com',
      avatarUrl: null,
    ),
    Tenant(
      id: '6',
      userId: 'user_106',
      fullName: 'Omar Ali',
      email: 'omar@example.com',
      avatarUrl: null,
    ),
  ];

  List<Tenant> get _filteredTenants {
    if (_searchController.text.isEmpty) return _tenants;
    return _tenants.where((tenant) {
      return tenant.fullName.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ||
          (tenant.email?.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ??
              false);
    }).toList();
  }

  int get _selectedCount {
    return _tenants.where((tenant) => tenant.isSelected).length;
  }

  @override
  void initState() {
    super.initState();
    _fetchTenants();
  }

  Future<void> _fetchTenants() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _toggleTenant(String userId) {
    setState(() {
      final index = _tenants.indexWhere((tenant) => tenant.userId == userId);
      if (index != -1) {
        _tenants[index].isSelected = !_tenants[index].isSelected;
      }
    });
  }

  void _validateGroupName(String value) {
    if (value.isEmpty) {
      _groupNameError = 'Group name is required';
    } else if (value.length > 50) {
      _groupNameError = 'Group name must be 50 characters or less';
    } else {
      _groupNameError = null;
    }
    setState(() {});
  }

  void _createGroup() {
    final groupName = _groupNameController.text.trim();

    _validateGroupName(groupName);

    if (_groupNameError != null) {
      _showError('Please enter a valid group name');
      return;
    }

    if (_selectedCount == 0) {
      _showError('Please select at least one tenant');
      return;
    }

    setState(() => _isCreating = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isCreating = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Group chat created successfully'),
          backgroundColor: AppColors.primaryLight,
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.destructiveLight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(theme),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGroupNameInput(theme),
            const SizedBox(height: 24),
            _buildSearchTenants(theme),
            const SizedBox(height: 16),
            _buildTenantsList(theme),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Create Group Chat',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
            onPressed: _isCreating ||
                    _groupNameController.text.isEmpty ||
                    _selectedCount == 0
                ? null
                : _createGroup,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryLight,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isCreating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Create'),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupNameInput(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Group Name',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _groupNameError != null
                  ? AppColors.destructiveLight
                  : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.people,
                color: AppColors.mutedForegroundLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _groupNameController,
                  onChanged: _validateGroupName,
                  maxLength: 50,
                  decoration: InputDecoration(
                    hintText: 'Enter group name (max 50 characters)...',
                    hintStyle: TextStyle(color: AppColors.mutedForegroundLight),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        if (_groupNameError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _groupNameError!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.destructiveLight,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchTenants(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Tenants ($_selectedCount selected)',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.search,
                color: AppColors.mutedForegroundLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search tenants...',
                    hintStyle: TextStyle(color: AppColors.mutedForegroundLight),
                    border: InputBorder.none,
                  ),
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTenantsList(ThemeData theme) {
    if (_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              const CircularProgressIndicator(color: AppColors.primaryLight),
              const SizedBox(height: 16),
              Text(
                'Loading tenants...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedForegroundLight,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredTenants.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              Icon(
                Icons.people_outline,
                size: 64,
                color: AppColors.mutedForegroundLight,
              ),
              const SizedBox(height: 16),
              Text(
                'No tenants found',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedForegroundLight,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredTenants.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final tenant = _filteredTenants[index];
        return _buildTenantItem(tenant, theme);
      },
    );
  }

  Widget _buildTenantItem(Tenant tenant, ThemeData theme) {
    return GestureDetector(
      onTap: () => _toggleTenant(tenant.userId),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  tenant.fullName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tenant.fullName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (tenant.email != null)
                    Text(
                      tenant.email!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedForegroundLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Checkbox(
              value: tenant.isSelected,
              onChanged: (_) => _toggleTenant(tenant.userId),
              activeColor: AppColors.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




























// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Group Chat',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF22C55E),
//         useMaterial3: true,
//         fontFamily: 'Poppins',
//         scaffoldBackgroundColor: const Color(0xFFFAFAFA),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const CreateGroupChatScreen(),
//     );
//   }
// }

// // ============================================
// // TENANT MODEL
// // ============================================
// class Tenant {
//   final String id;
//   final String userId;
//   final String fullName;
//   final String? email;
//   final String? avatarUrl;
//   bool isSelected;

//   Tenant({
//     required this.id,
//     required this.userId,
//     required this.fullName,
//     this.email,
//     this.avatarUrl,
//     this.isSelected = false,
//   });
// }

// // ============================================
// // CREATE GROUP CHAT SCREEN
// // ============================================
// class CreateGroupChatScreen extends StatefulWidget {
//   const CreateGroupChatScreen({super.key});

//   @override
//   State<CreateGroupChatScreen> createState() => _CreateGroupChatScreenState();
// }

// class _CreateGroupChatScreenState extends State<CreateGroupChatScreen> {
//   final TextEditingController _groupNameController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();
//   bool _isLoading = false;
//   bool _isCreating = false;
//   String? _groupNameError;

//   // Define colors
//   static const Color primaryColor = Color(0xFF22C55E);
//   static const Color backgroundColor = Color(0xFFFAFAFA);
//   static const Color surfaceColor = Color(0xFFFFFFFF);
//   static const Color onSurfaceColor = Color(0xFF1A1A1A);
//   static const Color outlineColor = Color(0xFFE5E5E7);
//   static const Color mutedForegroundColor = Color(0xFF737373);
//   static const Color errorColor = Color(0xFFDC2626);

//   // Sample tenants data
//   final List<Tenant> _tenants = [
//     Tenant(
//       id: '1',
//       userId: 'user_101',
//       fullName: 'Killam James',
//       email: 'killam@example.com',
//       avatarUrl: null,
//     ),
//     Tenant(
//       id: '2',
//       userId: 'user_102',
//       fullName: 'John Smith',
//       email: 'john@example.com',
//       avatarUrl: null,
//     ),
//     Tenant(
//       id: '3',
//       userId: 'user_103',
//       fullName: 'Sarah Johnson',
//       email: 'sarah@example.com',
//       avatarUrl: null,
//     ),
//     Tenant(
//       id: '4',
//       userId: 'user_104',
//       fullName: 'Ahmed Mohamed',
//       email: 'ahmed@example.com',
//       avatarUrl: null,
//     ),
//     Tenant(
//       id: '5',
//       userId: 'user_105',
//       fullName: 'Fatima Hassan',
//       email: 'fatima@example.com',
//       avatarUrl: null,
//     ),
//     Tenant(
//       id: '6',
//       userId: 'user_106',
//       fullName: 'Omar Ali',
//       email: 'omar@example.com',
//       avatarUrl: null,
//     ),
//   ];

//   List<Tenant> get _filteredTenants {
//     if (_searchController.text.isEmpty) return _tenants;
//     return _tenants.where((tenant) {
//       return tenant.fullName.toLowerCase().contains(
//             _searchController.text.toLowerCase(),
//           ) ||
//           (tenant.email?.toLowerCase().contains(
//                 _searchController.text.toLowerCase(),
//               ) ??
//               false);
//     }).toList();
//   }

//   int get _selectedCount {
//     return _tenants.where((tenant) => tenant.isSelected).length;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchTenants();
//   }

//   Future<void> _fetchTenants() async {
//     setState(() => _isLoading = true);
//     await Future.delayed(const Duration(seconds: 1)); // Simulate API call
//     setState(() => _isLoading = false);
//   }

//   void _toggleTenant(String userId) {
//     setState(() {
//       final index = _tenants.indexWhere((tenant) => tenant.userId == userId);
//       if (index != -1) {
//         _tenants[index].isSelected = !_tenants[index].isSelected;
//       }
//     });
//   }

//   void _validateGroupName(String value) {
//     if (value.isEmpty) {
//       _groupNameError = 'Group name is required';
//     } else if (value.length > 50) {
//       _groupNameError = 'Group name must be 50 characters or less';
//     } else {
//       _groupNameError = null;
//     }
//     setState(() {});
//   }

//   void _createGroup() {
//     final groupName = _groupNameController.text.trim();
    
//     // Validate
//     _validateGroupName(groupName);
    
//     if (_groupNameError != null) {
//       _showError('Please enter a valid group name');
//       return;
//     }
    
//     if (_selectedCount == 0) {
//       _showError('Please select at least one tenant');
//       return;
//     }
    
//     setState(() => _isCreating = true);
    
//     // Simulate API call
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() => _isCreating = false);
      
//       // Show success
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Group chat created successfully'),
//           backgroundColor: primaryColor,
//         ),
//       );
      
//       // Navigate back
//       Future.delayed(const Duration(seconds: 1), () {
//         Navigator.of(context).pop();
//       });
//     });
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: errorColor,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Group Name Input
//             _buildGroupNameInput(),
//             const SizedBox(height: 24),

//             // Search Tenants
//             _buildSearchTenants(),
//             const SizedBox(height: 16),

//             // Tenants List
//             _buildTenantsList(),
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: const Text(
//         'Create Group Chat',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: ElevatedButton(
//             onPressed: _isCreating || _groupNameController.text.isEmpty || _selectedCount == 0
//                 ? null
//                 : _createGroup,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: _isCreating
//                 ? const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : const Text('Create'),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGroupNameInput() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Group Name',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: onSurfaceColor,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: surfaceColor,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: _groupNameError != null ? errorColor : outlineColor,
//             ),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 12),
//               const Icon(
//                 Icons.people,
//                 color: mutedForegroundColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: TextField(
//                   controller: _groupNameController,
//                   onChanged: _validateGroupName,
//                   maxLength: 50,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter group name (max 50 characters)...',
//                     border: InputBorder.none,
//                     counterText: '',
//                   ),
//                   style: const TextStyle(
//                     color: onSurfaceColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (_groupNameError != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               _groupNameError!,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: errorColor,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSearchTenants() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Tenants ($_selectedCount selected)',
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: onSurfaceColor,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: surfaceColor,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: outlineColor),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 12),
//               const Icon(
//                 Icons.search,
//                 color: mutedForegroundColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: (_) => setState(() {}),
//                   decoration: const InputDecoration(
//                     hintText: 'Search tenants...',
//                     border: InputBorder.none,
//                   ),
//                   style: const TextStyle(
//                     color: onSurfaceColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTenantsList() {
//     if (_isLoading) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 32),
//           child: Column(
//             children: [
//               const CircularProgressIndicator(color: primaryColor),
//               const SizedBox(height: 16),
//               Text(
//                 'Loading tenants...',
//                 style: TextStyle(
//                   color: mutedForegroundColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     if (_filteredTenants.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 32),
//           child: Column(
//             children: [
//               const Icon(
//                 Icons.people_outline,
//                 size: 64,
//                 color: mutedForegroundColor,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'No tenants found',
//                 style: TextStyle(
//                   color: mutedForegroundColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: _filteredTenants.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 8),
//       itemBuilder: (context, index) {
//         final tenant = _filteredTenants[index];
//         return _buildTenantItem(tenant);
//       },
//     );
//   }

//   Widget _buildTenantItem(Tenant tenant) {
//     return GestureDetector(
//       onTap: () => _toggleTenant(tenant.userId),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: surfaceColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             // Avatar
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Center(
//                 child: Text(
//                   tenant.fullName[0].toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),

//             // Tenant Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     tenant.fullName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: onSurfaceColor,
//                     ),
//                   ),
//                   if (tenant.email != null)
//                     Text(
//                       tenant.email!,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: mutedForegroundColor,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                 ],
//               ),
//             ),

//             // Checkbox
//             Checkbox(
//               value: tenant.isSelected,
//               onChanged: (_) => _toggleTenant(tenant.userId),
//               activeColor: primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }