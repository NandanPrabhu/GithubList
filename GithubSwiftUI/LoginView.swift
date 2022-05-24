//
//  LoginView.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 20/05/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var output = LoginOutput()
    @ObservedObject var input = LoginInput()

    @State var isContentViewShown: Bool = false
    init(viewModel: LoginViewModel) {
        self.output = viewModel.transform(input: input)
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("", isActive: $isContentViewShown) {
                    ContentView(viewModel: ContentViewModel())
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(false)
//                        .navigationBarTitle("Search Text")
//                        .navigationBarTitleDisplayMode(.inline)
                }
                Spacer()
                Group {
                    VStack(alignment: .leading) {
                        TextField("", text: $input.userName)
                            .placeholder(when: input.userName.isEmpty) {
                                Text("Enter user name")
                                    .foregroundColor(.white)
                            }
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Color.gray)
                            .border(Color.white)
                            .cornerRadius(4)
                    }.padding([.leading, .trailing], 30)
                }.padding(.bottom, 30)
                
                Group {
                    VStack(alignment: .leading) {
                        SecureField("", text: $input.password)
                            .placeholder(when: input.password.isEmpty) {
                                Text("Enter Password")
                                    .foregroundColor(.white)
                            }
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Color.gray)
                            .border(Color.white)
                            .cornerRadius(4)
                    }.padding([.leading, .trailing], 30)
                }.padding(.bottom, 50)
                
                Group {
                    Button("Login") {
                        isContentViewShown = true
                    }
                    .disabled(!output.loginButtonEnabled)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(output.loginButtonEnabled ? Color.blue : Color.blue.opacity(0.5))
                    .cornerRadius(4)
                }
                Spacer()
            }.background(Color.black)
        }
    }
}


extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
