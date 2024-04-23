import 'package:auctionwesbank/pages/landlord/tedits/pages/home_page_land.dart';
import 'package:auctionwesbank/pages/login_page.dart';
import 'package:auctionwesbank/pages/tenant/topoedits/dashboard/homepagetenant.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // For now, let's hardcode the authentication
    // Replace the hardcoded values with your desired email and password
    // email topo@mailcom pass 123 opens admin page
    // while lefika@mail.com pass 321 opens tenant page
    
    // Hardcoded user credentials
    const String adminEmail = "topo@mail.com";
   // const String adminPassword = "123";
    const String tenantEmail = "lefika@mail.com";
    //const String tenantPassword = "321";

    // Hardcoded credentials check
    final String? currentUserEmail = "topo@mail.com"; // Change this to your user's email

    // Check if user is logged in
    if (currentUserEmail != null) {
      // User is logged in, check email and password to decide which page to show
      if (currentUserEmail == adminEmail) {
        // Admin user
        return HomePageLandy();
      } else if (currentUserEmail == tenantEmail) {
        // Tenant user
        return MyHomePageTenant();
      }
    }

    // User is not logged in or credentials don't match, show login page
    return LoginPage();
  }
}
