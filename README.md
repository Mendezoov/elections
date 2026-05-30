# Elections — iOS Voting App

An iOS app for managing local community elections, built with SwiftUI and SwiftData.

## Features

- **Voter Authentication** — voters log in using their 9-digit national ID number
- **Voting** — select an election list and up to 5 individual candidates
- **One-vote enforcement** — each voter ID can only cast one vote; repeat attempts are blocked
- **Admin Dashboard** — password-protected analytics screen with:
  - Total vote count
  - Bar chart of votes per list (using Swift Charts)
  - Top-ranked candidates across all lists
  - Per-list candidate breakdown
- **Onboarding screen** — shown on first launch to guide new users

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Persistence | SwiftData |
| Charts | Swift Charts |
| Architecture | MVVM |
| Language | Swift |
| Platform | iOS / iPadOS |

## Project Structure

```
elections/
├── Models/
│   ├── ModelsCandidate.swift       # Candidate SwiftData model
│   ├── ModelsElectionList.swift    # ElectionList SwiftData model
│   ├── ModelsVote.swift            # Vote record SwiftData model
│   └── ModelsVoter.swift           # Voter SwiftData model
├── ViewModels/
│   ├── ViewModelsAuthenticationViewModel.swift
│   ├── ViewModelsVotingViewModel.swift
│   └── ViewModelsAnalyticsViewModel.swift
├── Views/
│   ├── ViewsLoginView.swift        # Voter ID entry screen
│   ├── ViewsCandidatesView.swift   # List & candidate selection
│   ├── ViewsAnalyticsView.swift    # Admin analytics dashboard
│   ├── ViewsOnboardingView.swift   # First-launch onboarding
│   └── Components/
│       ├── ViewsComponentsCandidateRowView.swift
│       └── ViewsComponentsListCardView.swift
├── Services/
│   └── ServicesDataService.swift   # Initial seed data setup
└── ContentView.swift
```

## Getting Started

1. Clone the repository
2. Open `elections.xcodeproj` in Xcode
3. Select a simulator or connected device running iOS 17+
4. Build and run (`Cmd + R`)

> **Note:** Before deploying to production, change the admin credentials in `ViewModelsAnalyticsViewModel.swift`.

## Requirements

- Xcode 16+
- iOS 17+ / iPadOS 17+
- Swift 5.9+

## Author

**Mendez** — [@Mendezoov](https://github.com/Mendezoov)
