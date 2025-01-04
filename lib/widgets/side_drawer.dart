import 'package:flutter/material.dart';
// Ensure you import your DrawerListItem if it's separate

// Move NavItemData class outside the widget class
class NavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final int index;

  NavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.index,
  });
}

class CustomDrawer extends StatelessWidget {
  final int selectedPageIndex;
  final Function(int) onSelectPage;

  const CustomDrawer({
    super.key,
    required this.selectedPageIndex,
    required this.onSelectPage,
  });

  NavItemData _buildNavItemData({
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required int index,
  }) {
    return NavItemData(
      icon: icon,
      selectedIcon: selectedIcon,
      title: title,
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhone = MediaQuery.of(context).size.width <= 683;

    return Container(
      width: isPhone
          ? MediaQuery.of(context).size.width * 0.5 // Phone width (half screen)
          : 72, // Desktop width (navigation rail style)
      height: double.infinity,
      decoration: BoxDecoration(
        color: isPhone ? Colors.white : const Color(0xFF7E57C2),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(isPhone ? 4 : 12),
          bottomRight: Radius.circular(isPhone ? 4 : 12),
        ),
        boxShadow: isPhone
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(2, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        children: <Widget>[
          if (isPhone)
            _buildHeader(context, false)
          else
            _buildCompactHeader(
                context), // Compact header with 'E' logo for desktop
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isPhone ? 8 : 16,
                vertical: 8,
              ),
              children: <Widget>[
                const SizedBox(height: 8),
                ...[
                  _buildNavItemData(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    title: 'Dashboard',
                    index: 0,
                  ),
                  _buildNavItemData(
                    icon: Icons.category_outlined,
                    selectedIcon: Icons.category,
                    title: 'Categories',
                    index: 1,
                  ),
                  _buildNavItemData(
                    icon: Icons.inventory_outlined,
                    selectedIcon: Icons.inventory,
                    title: 'Products',
                    index: 2,
                  ),
                  _buildNavItemData(
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    title: 'Sales',
                    index: 3,
                  ),
                  _buildNavItemData(
                    icon: Icons.insert_chart_outlined,
                    selectedIcon: Icons.insert_chart,
                    title: 'Reports',
                    index: 4,
                  ),
                ].map((NavItemData item) => Column(
                      children: [
                        if (isPhone)
                          _buildNavItem(
                            context,
                            icon: item.icon,
                            selectedIcon: item.selectedIcon,
                            title: item.title,
                            index: item.index,
                            isPhone: isPhone,
                          )
                        else
                          _buildCompactNavItem(
                            context,
                            icon: item.icon,
                            selectedIcon: item.selectedIcon,
                            title: item.title,
                            index: item.index,
                          ),
                        const SizedBox(height: 4),
                      ],
                    )),
              ],
            ),
          ),
          if (isPhone)
            _buildLogoutButton(context, false)
          else
            _buildCompactLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCompactHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'E',
              style: TextStyle(
                color: Color(0xFF7E57C2),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedPageIndex == index;

    return Tooltip(
      message: title,
      preferBelow: false,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onSelectPage(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Center(
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected ? Colors.white : Colors.white70,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Tooltip(
        message: 'Logout',
        preferBelow: false,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Add logout logic here
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required int index,
    required bool isPhone,
  }) {
    final bool isSelected = selectedPageIndex == index;

    return ListTile(
      onTap: () => onSelectPage(index),
      selected: isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: Icon(
        isSelected ? selectedIcon : icon,
        color: isPhone
            ? (isSelected ? Theme.of(context).primaryColor : Colors.grey[600])
            : (isSelected ? Colors.white : Colors.white70),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isPhone
              ? (isSelected ? Theme.of(context).primaryColor : Colors.grey[800])
              : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      tileColor: isSelected
          ? (isPhone
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.white.withOpacity(0.1))
          : null,
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    final bool isSmallDevice = MediaQuery.of(context).size.width <= 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isSmallDevice ? 24 : (isDesktop ? 40 : 24),
        horizontal: isSmallDevice ? 16 : 24,
      ),
      decoration: BoxDecoration(
        color: isDesktop ? Colors.white : Theme.of(context).primaryColor,
        border: isDesktop
            ? Border(bottom: BorderSide(color: Colors.grey[200]!))
            : null,
        gradient: isSmallDevice
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.95),
                ],
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: isSmallDevice ? 48 : 60,
            width: isSmallDevice ? 48 : 60,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/company_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Text(
                'Elisam System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallDevice ? 18 : (isDesktop ? 20 : 16),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              if (isSmallDevice) ...[
                const SizedBox(height: 4),
                Text(
                  'Management Dashboard',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        onTap: () {
          // Add logout logic here
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.grey[100],
        leading: Icon(
          Icons.logout,
          color: Colors.grey[700],
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
