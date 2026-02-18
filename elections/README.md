# Election App - Palestine Central Elections

## Overview
A modern SwiftUI-based election app designed for small town elections in Palestine. The app follows the MVVM architecture pattern and uses SwiftData for persistence.

## Features

### 1. Onboarding
- Beautiful animated welcome screen
- Displays "Welcome to Palestine Central Elections"
- Uses "pslogo" image from assets
- Modern animations and transitions

### 2. Voter Authentication
- Login screen with ID number validation
- Arabic interface: "ادخل رقم الهوية"
- Validates against 5 pre-configured voter IDs (9 digits each)
- Prevents duplicate voting
- Error messages in Arabic

### 3. Voting System
- Three election lists with gradient colors:
  - قائمة بطيخ (Blue-Purple gradient)
  - قائمة بص حضرتك (Green-Teal gradient)
  - قائمة غرامك راح (Orange-Red gradient)
- Each list has 6 candidates
- Voters select one list, then up to 5 candidates
- Modern card-based UI with animations
- Submit button: "اضغط للتصويت"

### 4. Analytics Dashboard
- Protected by admin login (Username: "mendez", Password: "12345")
- Accessible via "Management Screen" button
- Displays:
  - Total vote counts
  - List performance charts
  - Top candidates ranking
  - Detailed results per list

## Pre-configured Voter IDs
The app comes with 5 test voter IDs:
1. 123456789
2. 987654321
3. 456789123
4. 321654987
5. 789123456

## Candidate Lists

### قائمة بطيخ
1. عاكف الجبر
2. يأجوج ومأجوج
3. المهدي المنتظر
4. شخص من علي زهاف
5. مرشح خامس
6. مرشح سادس

### قائمة بص حضرتك
1. ربحي الجبر
2. مرشح ثاني
3. مرشح ثالث
4. مرشح رابع
5. مرشح خامس
6. مرشح سادس

### قائمة غرامك راح
1. ططلي
2. مرشح ثاني
3. مرشح ثالث
4. مرشح رابع
5. مرشح خامس
6. مرشح سادس

## Architecture

### Models (SwiftData)
- **Voter**: Stores voter ID and voting status
- **ElectionList**: Stores list information and vote counts
- **Candidate**: Stores candidate details and vote counts
- **Vote**: Records each vote with timestamp

### ViewModels
- **AuthenticationViewModel**: Handles login and ID validation
- **VotingViewModel**: Manages candidate selection and vote submission
- **AnalyticsViewModel**: Handles analytics data and admin authentication

### Views
- **OnboardingView**: Welcome screen with animations
- **LoginView**: Voter authentication
- **CandidatesView**: Main voting interface
- **AnalyticsView**: Admin dashboard
- **Components**:
  - ListCardView: Expandable list cards
  - CandidateRowView: Individual candidate rows

### Services
- **DataService**: Initializes and manages database with sample data

## Requirements
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- SwiftUI
- SwiftData
- Swift Charts

## Setup Instructions

### 1. Add Logo Asset
Make sure to add an image named "pslogo" to your Assets catalog:
1. Open Assets.xcassets
2. Click the "+" button
3. Add "Image Set"
4. Name it "pslogo"
5. Drag your logo image into the asset

### 2. Build and Run
1. Open the project in Xcode
2. Select your target device/simulator
3. Press Cmd+R to build and run

### 3. Testing the App

#### Test Voting Flow:
1. Launch app → See onboarding
2. Tap "متابعة" → Login screen appears
3. Enter one of the test IDs (e.g., "123456789")
4. Select a list by tapping its header
5. Select up to 5 candidates
6. Tap "اضغط للتصويت"
7. See success message

#### Test Duplicate Vote Prevention:
1. Close the success message
2. Try logging in with the same ID again
3. You'll see an error: "لقد قمت بالتصويت بالفعل ادخل رقم هويه مختلف"

#### Test Analytics:
1. From login screen, tap "Management Screen"
2. Tap "تسجيل الدخول"
3. Enter username: "mendez"
4. Enter password: "12345"
5. View all voting results and charts

## Color Scheme
- **Primary Blues**: #3498DB, #2980B9
- **Success Green**: #2ECC71, #27AE60
- **Grays**: #ECF0F1, #BDC3C7, #95A5A6
- **Dark Text**: #2C3E50, #34495E
- **List 1 (بطيخ)**: #4A90E2 → #7B68EE
- **List 2 (بص حضرتك)**: #2ECC71 → #1ABC9C
- **List 3 (غرامك راح)**: #E74C3C → #F39C12

## Troubleshooting

### If data doesn't appear:
- The app automatically sets up sample data on first launch
- If needed, delete and reinstall the app to reset the database

### If logo doesn't appear:
- Make sure "pslogo" is correctly added to Assets.xcassets
- Check that the image name matches exactly (case-sensitive)

### If Arabic text looks wrong:
- The app uses SF Arabic font (built into iOS)
- Make sure you're testing on iOS 17.0 or later

## Future Enhancements
- Export results to PDF
- Real-time vote tracking
- Support for multiple elections
- Biometric authentication for voters
- QR code voter verification
- Email result reports

## License
Created by Mendez - February 18, 2026
