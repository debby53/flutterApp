# CheckMe Todo App

A feature-rich, Flutter-based todo application with Riverpod state management.

## Features

- **User Authentication** with email and password validation
- **Todo Management**:
  - Create, read, update and delete todos
  - Mark todos as complete with visual indicators
  - Set due dates with overdue notifications
- **Search & Categorization**:
  - Search todos by title or description
  - Organize todos by category (School, Personal, Urgent, etc.)
- **Modern UI/UX**:
  - Intuitive interface with smooth animations
  - Light and dark mode support
  - System theme integration

## Tech Stack

- **Flutter** for cross-platform development
- **Riverpod** for state management
- Local storage for data persistence

## Getting Started

### Prerequisites

- Flutter SDK (2.5.0 or higher)
- Dart SDK (2.14.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/checkme-todo-app.git
   ```

2. Navigate to project directory
   ```
   cd checkme-todo-app
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Run the app
   ```
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                # Entry point
├── models/                  # Data models
├── providers/               # Riverpod providers
├── screens/                 # App screens
│   ├── login_screen.dart    # Authentication
│   ├── home_screen.dart     # Todo dashboard
│   └── add_todo_screen.dart # Create new todos
└── widgets/                 # Reusable components
```

## Core Features Implementation

### Login Screen
- Email and password validation
- Secure authentication flow
- Navigation to home screen

### Home Screen (Todo Dashboard)
- Welcome message with user's name
- Todo list with completion status
- Floating action button for adding new todos
- Swipe to delete functionality
- Long-press for additional options

### Todo Management
- Add new tasks with title and description
- Set due dates for time-sensitive items
- Categorize todos for better organization
- Mark tasks as complete
- Delete unwanted tasks

### Search and Filter
- Search bar for finding specific todos
- Category filters
- Due date sorting options

### Theme Support
- Toggle between light and dark modes
- Option to follow system theme

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.0.0  # State management
  uuid: ^3.0.6              # Unique IDs
  intl: ^0.17.0             # Date formatting
  shared_preferences: ^2.0.15  # Local storage
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- - Riverpod for elegant state management solutions

## some images representing the repo
  ![image](https://github.com/user-attachments/assets/e8234403-c60e-4972-838d-ccbbba303e30)
  ![image](https://github.com/user-attachments/assets/0cdde9d0-2744-4497-b717-3c0a810ef836)
  ![image](https://github.com/user-attachments/assets/5a849bf9-880c-4071-a3d7-fe4bc391d3a7)
  ![image](https://github.com/user-attachments/assets/bab24a09-cb50-4377-a2ef-06f359ef9820)

  ### etc




