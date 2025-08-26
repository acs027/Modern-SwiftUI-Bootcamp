//
//  ContentView.swift
//  UserProfile
//
//  Created by ali cihan on 26.08.2025.
//

import SwiftUI

struct ContentView: View {
    let user = User.example
    
    var body: some View {
        LinearGradient(colors: [.blue, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 12) {
                    header
                    infoSection
                    aboutMe
                    buttons
                }
            }
    }
    
    //MARK: - Header
    var header: some View {
        VStack {
            userImage
            Text(user.name)
                .font(.title)
                .bold()
            Text(user.description)
                .font(.subheadline)
        }
        .padding(.top, 10)
    }
    
    
    var userImage: some View {
        Image(user.imageName)
            .resizable()
            .mask(Circle())
            .frame(width: 100, height: 100)
    }
    
    //MARK: - Info
    var infoSection: some View {
        HStack(spacing: 12) {
            card(labelText: "Following", count: user.following)
            card(labelText: "Followers", count: user.followers)
            card(labelText: "Likes", count: user.likes)
        }
        .padding()
    }
    
    //MARK: - About me
    var aboutMe: some View {
        VStack {
            Text(user.title)
                .bold()
                .font(.title)
            ScrollView {
                Text(user.aboutMe)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            )
        }
        .padding()
    }
    
    
    //MARK: - Buttons
    var buttons: some View {
        HStack {
            customButton(title: "Message") {
                return
            }
            
            customButton(title: "Follow") {
                return
            }
        }
        .padding()
    }
    
    func customButton(title: String, method: @escaping () -> Void) -> some View {
        Button {
            method()
        } label : {
            RoundedRectangle(cornerRadius: 10)
                .overlay {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .bold()
                }
                .frame(height: 50)
        }
    }
    
    
    
    func card(labelText: String, count: Int) -> some View {
        VStack {
            Text(labelText)
                .font(.headline)
                .bold()
            Text("\(count)")
                .font(.title)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.teal)
        )
    }
}

#Preview {
    ContentView()
}


struct User {
    let name: String
    let description: String
    let followers: Int
    let following: Int
    let likes: Int
    let aboutMe: String
    let title: String
    let imageName: String
    
    static let example =
        User(name: "Ali Cihan", description: "Hello World", followers: 27, following: 27, likes: 27, aboutMe: """
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            """, title: "iOS Developer", imageName: "acs")
}
