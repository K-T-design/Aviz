# Aviz

**Aviz** is a Flutter-based mobile application for browsing, posting, and bookmarking real estate listings. Leveraging the Bloc pattern, a reactive repository, and map integration, Aviz offers a smooth, real-time experience for the users.

---

## 🚀 Features

- **Browse Listings**\
  View detailed real estate posts with attributes such as price, area, number of bedrooms, and location.

- **Post Your Own Listing**\
  Create and manage your own listings: set category, set price, area, and pick location on an interactive map.

- **Bookmark Favorites**\
  Save interesting listings to your “Bookmarks” for quick access later.

- **Map Integration**\
  — **Set Location** when posting: tap on the map widget to drop a pin.\
  — **View Location** on each listing: see exactly where the property is.

---

## 📦 Tech Stack

- **Frontend:**

  - Flutter & Dart
  - Bloc for state management
  - get\_it for dependency injection
  - RxDart for reactive repositories
  - Flutter Hooks
  - OpenStreetMap&#x20;

- **Backend APIs:**\
  Aviz relies on a Spring Boot–based REST API.\
  You can find  the API project here:\
  🔗 (will be added here soon) [Aviz Spring Boot API]()

---

## 🏗 Architecture

- **Presentation**
  - Pages UI & custom widgets.

- **Bloc & Repository**

  - **Bloc**: follows bloc per page appraoch.
  - **Repository**: uses rxdart and streams for making repositories reactive.

- **Data Sources**

  - **RemoteDataSource:** communicates with the API.
  - **LocalDataSource:** communicates with local db.

 
- **Core**
    - **Exception handling**
    - **Dio interceptors for retrying requests**
    - **Custom hooks**

---

## 🔧 Getting Started

1. **Clone the repo**

   ```bash
   git clone https://github.com/Hiwa-Shaloudegi/Aviz.git
   cd Aviz
   ```

2. **Configure API endpoint**\
   Change the `_baseUrl` in `core/constants/endpoints.dart` to your own API base URL:

   ```env
   static const _baseUrl = 'YOUR_BASE_URL';
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 📸 Screenshots & 🎥 Video

#### Screenshots



<p align="center">
  <img src="https://github.com/user-attachments/assets/6e64de39-1cf0-4bff-b0a5-93eaae1b0a6d" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/2c611ae3-8f2a-443d-a9dc-1420abdce90f" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/6d62c30a-d1d4-42fa-bd43-09ad713fb399" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/82e0e7e2-ddef-41ac-a2c8-7c3a27a5bdda" width="200"  hspace="4" />
</p>

---
<p align="center">
  <img src="https://github.com/user-attachments/assets/6a68bd76-4ef0-4c38-9405-b16d9d2091a1" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/4792667f-5874-4021-8bba-6b2326893a19" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/30132f8a-253f-4403-9253-dce8675bb101" width="200"  hspace="4" />
  <img src="https://github.com/user-attachments/assets/071b4f05-ff59-4e1d-a5ca-247a69967c77" width="200"  hspace="4" />
</p>

---
<p align="center">
    <img src="https://github.com/user-attachments/assets/379ce745-07ae-44a2-8d07-fbb92106806b" width="200"  hspace="4" />
    <img src="https://github.com/user-attachments/assets/fceccd3a-9bcd-4fc0-9c10-c8fd52c3ccfd" width="200"  hspace="4" />
    <img src="https://github.com/user-attachments/assets/6bbfee12-e34b-4a2e-ab46-43133049aa5b" width="200"  hspace="4" />
</p>

<p align="center">
    <img src="https://github.com/user-attachments/assets/d8b61af4-2dc8-4780-b1f1-5f8e1e8f237b" width="200"  hspace="4" />
    <img src="https://github.com/user-attachments/assets/2df0e6a3-9fee-4488-b32f-c2d73d755e70" width="200"  hspace="4" />
    <img src="https://github.com/user-attachments/assets/60c2d74a-a332-4a3f-8483-0660b9dd4b57" width="200"  hspace="4" />
</p>

---

#### Demo Video
Video will be added here soon


