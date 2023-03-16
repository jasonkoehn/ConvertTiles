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
    var body: some View {
        VStack(spacing: 13) {
            Group {
                Text("Welcome To")
                    .font(.system(size: 45))
                    .fontDesign(.monospaced)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
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
                        .font(.system(size: 28))
                        .foregroundColor(.blue)
                    Text("One week free trial than                   $0.49/month or $4.99/year")
                        .font(.system(size: 17))
                        .foregroundColor(.green)
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
                    if await AdaptyManager.shared.restorePurchases() {
                        pro = true
                        hasLaunchedBefore = true
                    }
                }
            }) {
                Text("Restore Purchase")
                    .font(.system(size: 17))
                    .foregroundColor(.blue)
            }
            Spacer()
            
            HStack{Spacer()}
        }
        .padding(.top, 20)
        .background(Color(red: 0.261, green: 0.261, blue: 0.261))
        .foregroundColor(.white)
    }
}
