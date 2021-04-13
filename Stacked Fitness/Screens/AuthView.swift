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
        ZStack {
            Color("background1")
                .ignoresSafeArea()
            VStack {
                
                Group {
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 130)
                    
                    Text("STACKED FITNESS").font(.title).fontWeight(.heavy).padding(.bottom).foregroundColor(.white)
                    
                    Text("GET ABSOLUTELY STACKED")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
    
                
                Group {
                    Divider()
                    
                    
                    
                    TextField("Email", text: $email)
                        .padding()
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        
                    
                    SecureField("Password", text: $password)
                        .padding([.leading, .trailing])
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        
                    
                    
                    if (error) {
                        // Show alert
                        Text("THERE HAS BEEN A TERRIBLE MISTAKE").padding()
                            .foregroundColor(.white)
                    }
                    
                    
                    Button(action: signIn, label: {
                        Text("Sign In").foregroundColor(.black)
                    }).frame(width: 100, height: 50, alignment: .center).background(Color.white).cornerRadius(16)
                }
                
                
                
                VStack {
                    Divider()
                    HStack(alignment: .center) {
                        Text("Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up.").foregroundColor(.white).font(.footnote).fontWeight(.heavy)
                        }
                    }
                    .padding()
                }
                Spacer()
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
        ZStack {
            Color("background1")
                .ignoresSafeArea()
            VStack {
            
                
                Text("Create an account")
                    .font(.title)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                
                TextField("Email", text: $email)
                    .padding()
                    .autocapitalization(.none)
                
                VStack(alignment: .leading) {
                    SecureField("Password", text: $password)
                    Text("At least 8 characters required.").font(.footnote)
                }.padding(.horizontal)
                
                if (error) {
                    // Show alert
                    Text("COULD NOT CREATE ACCOUNT")
                }
                
                Button(action: signUp, label: {
                    Text("Sign Up").foregroundColor(.black)
                }).frame(width: 100, height: 50, alignment: .center).background(Color.white).cornerRadius(16).padding()
                
                Divider()
                
                Text("Creating an account will make you the fittest man alive!")
                    .font(.footnote)
                    .lineLimit(nil)
                    .padding()
                
                Spacer()
                
            }
        }
    }
    
}



struct Auth_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
