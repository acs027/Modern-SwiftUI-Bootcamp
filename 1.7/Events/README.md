# Event Planner (MVVM, SwiftUI)

A simple **event management app** built with **SwiftUI** and **MVVM architecture**.  
Users can add, view, and delete events, as well as see how much time remains until an event occurs.  

---

## ✨ Features

- 📋 **Event List**
  - Events are separated into **Active** and **Expired** sections.  
  - Each event displays:
    - Title  
    - Remaining time until the event  
    - Event type + SF Symbol icon  
    - Reminder status (bell on/off)  

- ➕ **Add Event**
  - Add new events via a modal sheet.  
  - Form fields include:
    - Title (`TextField`)  
    - Date (`DatePicker`)  
    - Type (`Picker` with Birthday, Meeting, Holiday, Sport, Other)  
    - Reminder toggle (`Toggle`)  

- 🔍 **Detail View**
  - Tap on an event to view all details.  
  - Includes title, formatted date, remaining time, type with icon, and reminder status.  

- 🗑️ **Delete Events**
  - Swipe-to-delete for both Active and Expired events.  

---

## 🏗️ Architecture

This project follows **MVVM**:

- **Model**
  - `Event`: Represents an event with title, date, type, and reminder.  
  - `EventType`: Enum for event categories with associated SF Symbols.  

- **ViewModel**
  - `EventViewModel`: Manages event list, add/delete logic, and mock data loading.  

- **Views**
  - `EventView`: Main screen with Active/Expired lists and navigation.  
  - `EventAddView`: Modal form for creating events.  
  - `EventListRow`: Row view for each event in the list.  
  - `EventDetailView`: Displays full details of an event.  

---

<p align="center">
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/3e9b81e6-3421-42ba-a0f8-16734befb721" />
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/4a752ba7-8b29-4cc5-ad47-a58584336b2f" />
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/553797f6-c86e-4b4a-93da-9e42d447195e" />
</p>
