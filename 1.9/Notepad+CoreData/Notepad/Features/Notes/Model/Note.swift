//
//  Note.swift
//  Notepad
//
//  Created by ali cihan on 11.09.2025.
//

import Foundation

struct Note: Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var date: Date
}

extension Note {
    
    // MARK: - Static Mock Data Array
    static let mockNotes: [Note] = [
        Note(
            title: "Shopping List",
            content: "• Milk\n• Bread\n• Eggs\n• Apples\n• Chicken breast\n• Rice\n• Yogurt",
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Meeting Notes - Project Alpha",
            content: "Discussed the new feature requirements with the team. Key points:\n\n1. User authentication system\n2. Database migration plan\n3. UI/UX improvements\n4. Testing strategy\n\nNext meeting: Friday 2 PM",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Book Ideas",
            content: "Ideas for my next novel:\n\n- Time travel romance set in Victorian era\n- Mystery thriller in small mountain town\n- Sci-fi about AI consciousness\n- Historical fiction during WWII\n\nNeed to research publishers for fantasy genre.",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Workout Plan",
            content: "Monday: Chest & Triceps\n- Bench press 3x8\n- Incline dumbbell press 3x10\n- Dips 3x12\n- Tricep pushdowns 3x15\n\nWednesday: Back & Biceps\n- Pull-ups 3x8\n- Rows 3x10\n- Bicep curls 3x12\n\nFriday: Legs & Shoulders",
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Travel Itinerary - Japan",
            content: "Day 1: Tokyo arrival\n- Check into hotel in Shibuya\n- Visit Sensoji Temple\n- Dinner in Harajuku\n\nDay 2: Tokyo sightseeing\n- Tokyo Tower\n- Imperial Palace\n- Tsukiji Market\n\nDay 3: Day trip to Nikko\nDay 4: Travel to Kyoto",
            date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Recipe - Chocolate Chip Cookies",
            content: "Ingredients:\n- 2 1/4 cups flour\n- 1 tsp baking soda\n- 1 tsp salt\n- 1 cup butter, softened\n- 3/4 cup granulated sugar\n- 2 large eggs\n- 2 cups chocolate chips\n\nBake at 375°F for 9-11 minutes",
            date: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Swift Learning Notes",
            content: "Key concepts to remember:\n\n• Optionals and nil safety\n• Protocol-oriented programming\n• Value types vs Reference types\n• ARC (Automatic Reference Counting)\n• SwiftUI state management\n• Combine framework basics\n\nNext: Study Core Data integration",
            date: Calendar.current.date(byAdding: .day, value: -12, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Gift Ideas",
            content: "Mom's birthday (March 15):\n- Silk scarf from her favorite brand\n- Spa day voucher\n- Photo album of family memories\n\nDad's birthday (June 20):\n- New golf clubs\n- Book on history\n- Weekend fishing trip",
            date: Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Quotes & Inspiration",
            content: "\"The only way to do great work is to love what you do.\" - Steve Jobs\n\n\"Innovation distinguishes between a leader and a follower.\" - Steve Jobs\n\n\"Design is not just what it looks like and feels like. Design is how it works.\" - Steve Jobs\n\nRemember: Focus on solving problems, not just building features.",
            date: Calendar.current.date(byAdding: .day, value: -18, to: Date()) ?? Date()
        ),
        
        Note(
            title: "Home Improvement Tasks",
            content: "Priority tasks:\n✓ Fix leaky faucet in kitchen\n✓ Paint the living room walls\n• Install new light fixtures\n• Organize garage\n• Plant flowers in garden\n• Clean out basement\n\nBudget: $2000\nDeadline: End of month",
            date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date()
        )
    ]
}
