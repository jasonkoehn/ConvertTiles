//
//  LaunchView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/16/23.
//

import SwiftUI

struct LaunchView: View {
    @Binding var hasLaunchedBefore: Bool
    @Binding var pro: Bool
    @Binding var showPaywallView: Bool
    @State var showProgressView: Bool = false
    @State var showSucceededAlert: Bool = false
    @State var showFailedAlert: Bool = false
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Text("Welcome To")
                    .foregroundColor(.green)
                    .font(.system(size: 45))
                    .fontDesign(.monospaced)
                    .fontWeight(.semibold)
                Text("ConvertTiles")
                    .font(.system(size: 50))
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                    .rotationEffect(.degrees(355))
                Image("Icon")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(25)
                    .padding(10)
                Text("An app where unit converters live on tiles so that you can easily use more than one at a time.")
                    .font(.system(size: 21))
                    .frame(width: 310)
            }
            Spacer()
            Text("Get ConvertTiles Pro?")
                .font(.system(size: 24))
                .fontDesign(.monospaced)
            Button(action: {
                showPaywallView.toggle()
                hasLaunchedBefore = true
            }) {
                VStack {
                    Text("Learn More")
                        .foregroundColor(.blue)
                        .font(.system(size: 28))
                    Text("One week free trial than                   $0.49/month or $4.99/year")
                        .foregroundColor(.green)
                        .font(.system(size: 17))
                }
                .frame(width: 310, height: 80)
                .background(Color.black)
                .cornerRadius(10)
            }
            Button(action: {
                hasLaunchedBefore = true
            }) {
                Text("I'll think about it.")
                    .font(.system(size: 18))
            }
            Button(action: {
                Task {
                    showProgressView = true
                    if await AdaptyManager.shared.restorePurchase() {
                        pro = true
                        showSucceededAlert.toggle()
                        showProgressView = false
                    } else {
                        showFailedAlert.toggle()
                        showProgressView = false
                    }
                }
            }) {
                Text("Restore Purchase")
                    .foregroundColor(.blue)
                    .font(.system(size: 17))
            }
            Link("Contact Info and Privacy Policy", destination: URL(string: "https://jasonkoehn.github.io/converttiles")!)
                .foregroundColor(.blue)
                .font(.system(size: 12))
            Spacer()
            HStack{Spacer()}
        }
        .foregroundColor(.white)
        .padding(.top, 20)
        .background(Color(red: 0.261, green: 0.261, blue: 0.261))
        .overlay {
            if showProgressView {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea(.all)
                    ProgressView()
                }
            }
        }
        .alert("Restore Succeeded", isPresented: $showSucceededAlert) {
            Button(role: .cancel, action: {
                hasLaunchedBefore = true
            }) {
                Text("OK")
            }
        }
        .alert("Restore Failed", isPresented: $showFailedAlert) {
            Button(role: .cancel, action: {}) {
                Text("OK")
            }
        }
    }
}
