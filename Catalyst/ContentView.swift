//
//  ContentView.swift
//  Catalyst
//
//  Created by Andika on 10/10/19.
//  Copyright © 2019 DTEK. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

let myusername: String = "Username"
let mypassword: String = "supersecret"

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var didFail: Bool = false
    @State var didSuccess: Bool = false
    
    @State var didEdit: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                UserImage()
                
                UsernameTextField(username: $username, editingMode: $didEdit)
                
                PasswordTextField(password: $password)
                
                if didFail {
                    Text("The login credentials was invalid.")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if self.username == myusername && self.password == mypassword {
                        self.didFail = false
                        self.didSuccess = true
                    } else {
                        self.didFail = true
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                    .padding()
                        .frame(width: 200, height: 60)
                        .background(Color.blue)
                    .cornerRadius(15)
                }
            }.padding()
            if didSuccess {
                Text("Login succeeded!")
                .font(.headline)
                .frame(width: 250, height: 80)
                .background(Color.green)
                .cornerRadius(20.0)
                .foregroundColor(.white)
                .animation(Animation.default)
            }
        }.offset(y: didEdit ? -150 : 0)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

struct WelcomeText: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        }
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage")
        .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
        .clipped()
        .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct UsernameTextField: View {
    
    @Binding var username: String
    @Binding var editingMode: Bool
    
    var body: some View {
        return TextField("Username", text: $username, onEditingChanged: { edit in
            if edit == true {
                self.editingMode = true
            } else {
                self.editingMode = false
            }
        })
        .padding()
        .background(lightGreyColor)
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}

struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}
