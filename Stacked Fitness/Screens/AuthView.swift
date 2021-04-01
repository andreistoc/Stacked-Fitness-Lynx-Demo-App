//
//  SignInView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 29.03.2021.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct SignInView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            
            Group {
                
//                Image("logo")
//                    .resizable()
//                    .frame(width: 75, height: 75)
                
                Text("STACKED FITNESS").font(.title).padding(.bottom)
                
                Text("GET ABSOLUTELY STACKED ASAP.")
                    .font(.subheadline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Group {
                Divider()
                
                
                
                TextField("Email", text: $email)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding([.leading, .trailing])
                
                
                if (error) {
                    // Show alert
                    Text("THERE HAS BEEN A TERRIBLE MISTAKE")
                }
                
                
                
                Button("Sign in", action: signIn)
                    .padding()
            }
            
            
            
            VStack {
                Divider()
                HStack(alignment: .center) {
                    Text("Don't have an account?")
                        .font(.footnote)
                    
                    
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up.").font(.footnote)
                    }
                }
                .padding()
            }
            
            
        }
        
    }
}

struct SignUpView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signUp () {
        print("sign me up")
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                print("\(error)")
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body : some View {
        VStack {
            
            Text("Create an account")
                .font(.title)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .padding()
            
            VStack(alignment: .leading) {
                SecureField("Password", text: $password)
                Text("At least 8 characters required.").font(.footnote)
            }.padding(.horizontal)
            
            if (error) {
                // Show alert
                Text("COULD NOT CREATE ACCOUNT")
            }
            
            Button("Sign Up", action: signUp)
                .padding()
            
            Divider()
            
            Text("Creating an account will make you ABSOULTELY STACKED")
                .font(.footnote)
                .lineLimit(nil)
                .padding()
            
            Spacer()
            
        }
        
    }
    
}



struct Auth_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
