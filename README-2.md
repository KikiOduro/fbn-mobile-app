
# FBNMobile Flutter App

## App Overview

FBNMobile is a beginner-friendly Flutter application that simulates the core features of a modern mobile banking app. Users can log in, transfer funds, pay bills, view recent transactions, and track their account balances. The app uses Provider for simple state management and focuses on clean UI and intuitive navigation.

**Key Features:**
- Login screen with input validation
- Dashboard with dynamic welcome message and real-time balance
- Transfers to FBN and other banks with transaction history
- Bill payments with dropdown selection
- Recent purchases display on both Dashboard and Home
- Account balance display with "Add Funds" option
- Consistent branding using FBN color themes and styling

---

## How to Run the App

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/KikiOduro/fbn-mobile-app.git
   cd fbn-mobile-app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the App:**
   ```bash
   flutter run
   ```

4. **Simulator or Device:**
   Ensure you have a connected emulator or physical device.

---

## Key Challenges & What Was Learned

### 🔐 Form Validation
Learning to properly validate user input (e.g., login credentials and payment fields) was key. Managing error messages and UI feedback helped reinforce form usability.

### 🔄 State Management with Provider
Understanding how to structure and share app-wide data (e.g., transactions, balances) using `ChangeNotifierProvider` and `Consumer` was essential for real-time updates and inter-screen communication.

### 💳 UI Design and Layout
Designing a responsive and realistic dashboard with a Visa-style card, transaction list, and side menu required careful use of widgets like `Stack`, `Row`, `ListView`, and custom components.

### 🧪 Testing and Hot Reload Issues
Encountered typical beginner issues like context errors, Provider not found, and needing full restarts after adding providers. These were resolved by understanding widget tree scopes.

### 🎨 Polish and Finishing Touches
Using consistent fonts, button styles, and color schemes brought the app together. Managing overflow, padding, and alignment taught attention to visual details.

---

_This app was built as part of a coursework submission for Ashesi University's Mobile Development module._
