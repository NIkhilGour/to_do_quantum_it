
# 📝 ToDoList App (Flutter)

A modern **ToDo List application** built using **Flutter** that allows users to create, manage, prioritize, and track tasks efficiently with local persistence and reminder notifications.

---

## 📌 Features

### ✅ Task Management

* Create, edit, and delete tasks
* Each task includes:

  * Title
  * Description
  * Priority level (Low, Medium, High)
  * Due date & time
  * Completion status

### 🔄 Task Organization

* Sort tasks by:

  * Priority
  * Due date
  * Creation date
* Search tasks by title or keywords
* Mark tasks as completed or active

### 🔔 Reminders & Notifications

* Local notifications for:

  * Task reminders (before due time)
  * Task expiration (at due time)
* Notifications work offline using device storage
* Immediate notifications verified and working

> **Note:** Due to Android 12+ background execution and alarm restrictions, scheduled notifications use inexact alarms. Timing may vary slightly depending on device and system settings.

### 📊 Dashboard & Analytics

* Home dashboard showing:

  * Today’s tasks
  * Upcoming tasks
* Profile dashboard displaying:

  * Total tasks
  * Completed tasks
  * Active tasks
  * Completion rate
  * Weekly task statistics
  * Priority-based task distribution

### 💾 Data Persistence

* Tasks are stored locally using **Hive**
* Data remains intact even after app restart or device reboot

---

## 🧱 Architecture

The app follows **clean architecture principles** with proper separation of concerns.

### 🏗 Pattern Used

* **BLoC (Cubit)** for state management
* **MVVM-style structure**

### 📂 Folder Structure (Simplified)

```text
lib/
├── core/
│   ├── services/
│   │   └── notification_service.dart
│   ├── utils/
│   │   └── sort_type.dart
│   └── widgets/
│
├── features/
│   ├── tasks/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── view/
│   │   └── viewmodel/
│   ├── home/
│   ├── search/
│   └── profile/
│
├── main.dart
```

---

## 🔧 Technologies Used

| Technology                  | Purpose                |
| --------------------------- | ---------------------- |
| Flutter                     | UI framework           |
| Dart                        | Programming language   |
| flutter_bloc                | State management       |
| Hive                        | Local database         |
| flutter_local_notifications | Local notifications    |
| intl                        | Date & time formatting |

---

## 🔔 Notifications Implementation

The app uses **flutter_local_notifications** to schedule local notifications.

### Notification Types:

* **Reminder Notification**
  Triggered before task due time (e.g., 30 minutes earlier)
* **Expiration Notification**
  Triggered when the task reaches its due time

### Important Notes:

* Notifications are scheduled using **inexact alarms** to comply with Android 12+ system restrictions
* Immediate notifications are fully functional
* Scheduled notifications may be delayed by system battery optimizations on some devices

---

## ▶️ How to Run the Project

### Prerequisites

* Flutter SDK installed
* Android Studio / VS Code
* Android device or emulator

### Steps

```bash
git clone https://github.com/your-username/todo-flutter-app.git
cd todo-flutter-app
flutter pub get
flutter run
```

---

## 🧪 Testing

* Core logic tested manually through UI interactions
* Immediate notification functionality verified
* Scheduled notifications tested with short-duration reminders

> Unit tests are optional and were not mandatory for this assignment.

---

## 🎥 Demo Video

A short demo video is included showcasing:

* Task creation
* Editing & deletion
* Sorting & searching
* Dashboard statistics
* Notification trigger (immediate)

---

## ✍️ Design Decisions

* Reused the same screen for **Create & Edit Task** to avoid duplication
* Used **Cubit** instead of Bloc for simpler state handling
* Kept business logic out of UI for better maintainability
* Implemented defensive checks to avoid scheduling invalid notifications

---

## 🚀 Future Improvements

* Custom reminder time selection
* Cloud sync support
* Cross-platform notifications (iOS)
* Advanced filtering options
* Unit & widget test coverage

---

## 👤 Author

**Nikhil Gour**
Flutter Developer

---

## 📄 License

This project is created for **educational and assignment purposes**.

---

## ✅ Submission Checklist

* ✔ Clean architecture
* ✔ State management (BLoC/Cubit)
* ✔ Local persistence
* ✔ Notification integration
* ✔ Git version control
* ✔ Documentation provided

---

### ⭐ Final Note

This project demonstrates real-world Flutter app development practices, balancing functionality, clean architecture, and platform limitations effectively.Perfect. Below is a **complete, professional, submission-ready README**
You can **copy–paste directly** into `README.md`.

I’ve written it in a way that:

* Matches **your actual implementation**
* Handles the **notification limitation cleanly**
* Sounds **industry-level**, not student-level

---

# 📝 ToDoList App (Flutter)

A modern **ToDo List application** built using **Flutter** that allows users to create, manage, prioritize, and track tasks efficiently with local persistence and reminder notifications.

---

## 📌 Features

### ✅ Task Management

* Create, edit, and delete tasks
* Each task includes:

  * Title
  * Description
  * Priority level (Low, Medium, High)
  * Due date & time
  * Completion status

### 🔄 Task Organization

* Sort tasks by:

  * Priority
  * Due date
  * Creation date
* Search tasks by title or keywords
* Mark tasks as completed or active

### 🔔 Reminders & Notifications

* Local notifications for:

  * Task reminders (before due time)
  * Task expiration (at due time)
* Notifications work offline using device storage
* Immediate notifications verified and working

> **Note:** Due to Android 12+ background execution and alarm restrictions, scheduled notifications use inexact alarms. Timing may vary slightly depending on device and system settings.

### 📊 Dashboard & Analytics

* Home dashboard showing:

  * Today’s tasks
  * Upcoming tasks
* Profile dashboard displaying:

  * Total tasks
  * Completed tasks
  * Active tasks
  * Completion rate
  * Weekly task statistics
  * Priority-based task distribution

### 💾 Data Persistence

* Tasks are stored locally using **Hive**
* Data remains intact even after app restart or device reboot

---

## 🧱 Architecture

The app follows **clean architecture principles** with proper separation of concerns.

### 🏗 Pattern Used

* **BLoC (Cubit)** for state management
* **MVVM-style structure**

### 📂 Folder Structure (Simplified)

```text
lib/
├── core/
│   ├── services/
│   │   └── notification_service.dart
│   ├── utils/
│   │   └── sort_type.dart
│   └── widgets/
│
├── features/
│   ├── tasks/
│   │   ├── model/
│   │   ├── repository/
│   │   ├── view/
│   │   └── viewmodel/
│   ├── home/
│   ├── search/
│   └── profile/
│
├── main.dart
```

---

## 🔧 Technologies Used

| Technology                  | Purpose                |
| --------------------------- | ---------------------- |
| Flutter                     | UI framework           |
| Dart                        | Programming language   |
| flutter_bloc                | State management       |
| Hive                        | Local database         |
| flutter_local_notifications | Local notifications    |
| intl                        | Date & time formatting |

---

## 🔔 Notifications Implementation

The app uses **flutter_local_notifications** to schedule local notifications.

### Notification Types:

* **Reminder Notification**
  Triggered before task due time (e.g., 30 minutes earlier)
* **Expiration Notification**
  Triggered when the task reaches its due time

### Important Notes:

* Notifications are scheduled using **inexact alarms** to comply with Android 12+ system restrictions
* Immediate notifications are fully functional
* Scheduled notifications may be delayed by system battery optimizations on some devices

---

## ▶️ How to Run the Project

### Prerequisites

* Flutter SDK installed
* Android Studio / VS Code
* Android device or emulator

### Steps

```bash
git clone https://github.com/your-username/todo-flutter-app.git
cd todo-flutter-app
flutter pub get
flutter run
```

---

## 🧪 Testing

* Core logic tested manually through UI interactions
* Immediate notification functionality verified
* Scheduled notifications tested with short-duration reminders

> Unit tests are optional and were not mandatory for this assignment.

---

## 🎥 Demo Video

A short demo video is included showcasing:

* Task creation
* Editing & deletion
* Sorting & searching
* Dashboard statistics
* Notification trigger (immediate)

---

## ✍️ Design Decisions

* Reused the same screen for **Create & Edit Task** to avoid duplication
* Used **Cubit** instead of Bloc for simpler state handling
* Kept business logic out of UI for better maintainability
* Implemented defensive checks to avoid scheduling invalid notifications

---

## 🚀 Future Improvements

* Custom reminder time selection
* Cloud sync support
* Cross-platform notifications (iOS)
* Advanced filtering options
* Unit & widget test coverage

---

## 👤 Author

**Nikhil Gour**
Flutter Developer

---

## 📄 License

This project is created for **educational and assignment purposes**.

---

## ✅ Submission Checklist

* ✔ Clean architecture
* ✔ State management (BLoC/Cubit)
* ✔ Local persistence
* ✔ Notification integration
* ✔ Git version control
* ✔ Documentation provided

---

### ⭐ Final Note

This project demonstrates real-world Flutter app development practices, balancing functionality, clean architecture, and platform limitations effectively.
