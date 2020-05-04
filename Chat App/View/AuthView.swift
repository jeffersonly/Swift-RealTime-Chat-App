//
//  AuthView.swift
//  Chat App
//
//  Created by Jefferson Ly on 4/26/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore

    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .font(.system(size: 32, weight: .heavy))
            Text("Sign in to continue")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("Gray"))
            VStack(spacing: 18) {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(UIColor.purple), lineWidth: 1))
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(UIColor.purple), lineWidth: 1))
            }
            .padding(.vertical, 64)
            
            Button(action: signIn) {
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.blue)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            
            if(error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            GoogleSignView()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .frame(height: 50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .cornerRadius(5)
            
            FaceBookLoginView()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .frame(height: 50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .cornerRadius(5)
            
            Spacer()
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("I'm a new user.")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.primary)
                    Text("Create an account")
                        .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(UIColor.blue))
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var error: String = ""
    @State var isShowingImagePicker = false
    @State var imageInBox = UIImage()
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, name: name, password: password, image: imageInBox) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.name = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
            Text("Sign up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("Gray"))
            
            //Image Picker for profile
            Image(uiImage: imageInBox)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
            Button(action: {
                self.isShowingImagePicker.toggle()
            }, label: {
                Text("Select Image")
                    .font(.system(size: 18))
            })
                .sheet(isPresented: $isShowingImagePicker, content: {
                    ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$imageInBox)
                })
            
            VStack(spacing: 18) {
                TextField("Email Address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(UIColor.purple), lineWidth: 1))
                TextField("Name", text: $name)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(UIColor.purple), lineWidth: 1))
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(UIColor.purple), lineWidth: 1))
            }.padding(.vertical, 64)
            
            Button(action: signUp) {
                Text("Create Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.purple), Color(UIColor.blue)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            
            if(error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
        }.padding(.horizontal, 32)
    }
}

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}

//Image box for registering image
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(selectedImageFromPicker)
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}
