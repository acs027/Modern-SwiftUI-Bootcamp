# Notes App (SwiftUI)

A simple and colorful **Notes app** built with SwiftUI that allows users to create, view, and delete notes. Notes are persisted locally using `UserDefaults`. Each note row has a random background color and can be expanded to show full content and creation date.

---

## Features

- Create new notes with **title** and **content**.
- View all saved notes in a scrollable list.
- Expand/collapse note rows to show full content and date.
- Delete notes using swipe-to-delete.
- Random background color for each note row.
- Persistent storage using `UserDefaults`.
- Smooth animations for expanding and collapsing notes.

---

## Screenshots

<p align="center">
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/0e031c28-1e02-4d88-95f5-f34c8f5d5d55" />
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/1d77f0b3-fd3e-48e8-8d3f-bb06b746b3af" />
    <img width="300" alt="Image" src="https://github.com/user-attachments/assets/e37b476f-6abc-4401-a69f-15fbb2a26899" />
</p>

---

## Components

### NotesView
- Main view displaying all notes in a `List`.
- Floating "+" button to add a new note.
- Loads mock data if no notes exist.

### NoteRow
- Displays a single note.
- Tap anywhere on the row to expand/collapse content.
- Shows title, content, and creation date.
- Random background color for each note.

### AddNoteSheet
- Modal view for creating a new note.
- Uses `TextField` for the title and `TextEditor` for multi-line content.

### NotesViewModel
- Handles fetching, saving, adding, and deleting notes.
- Persists notes in `UserDefaults`.
- Supports loading mock data for initial testing.

### Note
- Data model conforming to `Codable` and `Identifiable`.
- Stores note title, content, creation date, and unique ID.

---

