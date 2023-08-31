//
//  LaunchView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/16/23.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var subManager: SubscriptionManager
    @Binding var versionNumber: String
    @Binding var showPaywallView: Bool
    @State var showProgressView: Bool = false
    @State var showSucceededAlert: Bool = false
    @State var showFailedAlert: Bool = false
    @State var price: String = ""
    var body: some View {
        ScrollView {
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
                VStack(alignment: .leading) {
                    Text("-many more converter options")
                        .foregroundColor(.purple)
                    Text("-light or dark mode options")
                        .foregroundColor(.black)
                    Text("-more than four converters at a time")
                        .foregroundColor(.green)
                    Text("-support further app development")
                        .foregroundColor(.blue)
                    Text("-and many more!")
                        .foregroundColor(.orange)
                }
                .font(.system(size: 19))
                Button(action: {
                    showPaywallView.toggle()
                    versionNumber = store.appVersionNumber
                }) {
                    VStack {
                        Text("10 Day Free Trial")
                            .foregroundStyle(.green)
                        Text("Learn More...")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .fontDesign(.serif)
                        HStack {
                            Text("Lifetime Purchase:  ")
                                .foregroundStyle(.purple)
                                .font(.system(size: 15))
                            Text(price)
                                .foregroundColor(.blue)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(width: 310, height: 70)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                Button(action: {
                    versionNumber = store.appVersionNumber
                }) {
                    Text("I'll think about it.")
                        .font(.system(size: 18))
                }
                Button(action: {
                    Task {
                        showProgressView = true
                        if await subManager.restorePurchase() {
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
                versionNumber = store.appVersionNumber
            }) {
                Text("OK")
            }
        }
        .alert("Restore Failed", isPresented: $showFailedAlert) {
            Button(role: .cancel, action: {}) {
                Text("OK")
            }
        }
        .task {
            price = await AdaptyManager.shared.getPrice()
            await subManager.initSubStatus()
        }
    }
}
