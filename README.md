# Elections — iOS Voting App

A clean, offline-first iOS app for running local community elections. Voters authenticate by national ID, pick a list and up to 5 candidates, and an admin-protected dashboard shows live results with charts.

Built with **SwiftUI + SwiftData**, no backend or internet connection required.

---

## Screenshots

| Onboarding | Login | Voting | Analytics |
|:-:|:-:|:-:|:-:|
| Animated welcome screen | Voter ID entry | List & candidate selection | Admin results dashboard |

---

## Features

- Voter authentication by 9-digit national ID number
- One-vote enforcement — repeat attempts are blocked automatically
- Select one election list, then up to 5 individual candidates
- Animated onboarding screen with typing effect and haptic feedback
- Password-protected admin dashboard with:
  - Total vote count
  - Bar chart per list (Swift Charts)
  - Top 10 ranked candidates
  - Per-list candidate breakdown
- Fully offline — all data stored locally with SwiftData
- Arabic RTL UI (right-to-left layout)

---

## Requirements

| Tool | Minimum Version |
|---|---|
| Xcode | 16+ |
| iOS / iPadOS | 17+ |
| Swift | 5.9+ |

---

## Getting Started

```bash
git clone https://github.com/Mendezoov/elections.git
cd elections
open elections.xcodeproj
```

Then press **Cmd + R** to build and run on a simulator or device.

No dependencies, no package manager, no setup needed.

---

## Customization

Everything you need to adapt this app for your own election is in three files.

### 1. Voter IDs — `elections/ServicesDataService.swift`

Replace the hardcoded IDs with your registered voters' 9-digit ID numbers:

```swift
let voterIDs = [
    "123456789",
    "987654321",
    // add as many as you need...
]
```

### 2. Election Lists & Candidates — `elections/ServicesDataService.swift`

Change the list names, their gradient colors (hex), and all candidate names/positions:

```swift
let lists = [
    ElectionList(name: "Your First List",  colorStart: "4A90E2", colorEnd: "7B68EE"),
    ElectionList(name: "Your Second List", colorStart: "2ECC71", colorEnd: "1ABC9C"),
    ElectionList(name: "Your Third List",  colorStart: "E74C3C", colorEnd: "F39C12"),
]
```

```swift
Candidate(name: "Candidate Name", listName: "Your First List", position: 1),
```

> `listName` in each `Candidate` must exactly match the corresponding `ElectionList.name`.

### 3. Admin Credentials — `elections/ViewModelsAnalyticsViewModel.swift`

Change the username and password before distributing the app:

```swift
private let adminUsername = "Mendez"   // ← change this
private let adminPassword = "12345"    // ← change this
```

### 4. Onboarding Title — `elections/ViewsOnboardingView.swift`

Update the welcome headline shown on the animated intro screen:

```swift
private let fullText = "Your election committee name here"
```

### 5. App Logo — `elections/Assets.xcassets`

Replace the `pslogo` image asset with your own logo. The image is displayed at 200×200 pt on the onboarding screen.

---

## Project Structure

```
elections/
├── Models/
│   ├── ModelsCandidate.swift          # Candidate data model
│   ├── ModelsElectionList.swift       # Election list data model
│   ├── ModelsVote.swift               # Vote record model
│   └── ModelsVoter.swift              # Voter model
│
├── ViewModels/
│   ├── ViewModelsAuthenticationViewModel.swift   # Voter ID validation logic
│   ├── ViewModelsVotingViewModel.swift           # List/candidate selection & vote submission
│   └── ViewModelsAnalyticsViewModel.swift        # Admin auth + results aggregation
│
├── Views/
│   ├── ViewsLoginView.swift           # Voter ID entry screen
│   ├── ViewsCandidatesView.swift      # List & candidate selection screen
│   ├── ViewsAnalyticsView.swift       # Admin analytics dashboard
│   ├── ViewsOnboardingView.swift      # Animated first-launch intro
│   └── Components/
│       ├── ViewsComponentsCandidateRowView.swift
│       └── ViewsComponentsListCardView.swift
│
├── Services/
│   └── ServicesDataService.swift      # Seeds initial voter, list & candidate data
│
└── ContentView.swift                  # Root view (onboarding gate + nav)
```

---

## Architecture

The app follows **MVVM** with SwiftData as the persistence layer.

- **Models** are `@Model` classes managed by a SwiftData `ModelContainer`
- **ViewModels** are `@Observable` classes injected via `@State` into their views
- **Views** read from the environment `modelContext` and pass it into ViewModels
- No Combine — async state changes happen directly via `@Observable`

---

## Data Flow

```
App launch → DataService seeds voters / lists / candidates (once)
     ↓
ContentView shows Onboarding → Login
     ↓
AuthenticationViewModel validates voter ID → navigates to CandidatesView
     ↓
VotingViewModel handles selection → submitVote() marks voter as voted
     ↓
AnalyticsViewModel reads all Vote / ElectionList / Candidate records → displays charts
```

---

## License

MIT — see [LICENSE](LICENSE) for details.

## Author

**Mendez** — [@Mendezoov](https://github.com/Mendezoov)
