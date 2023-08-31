//
//  PaywallView.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/13/23.
//

import SwiftUI
import Adapty

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var subManager: SubscriptionManager
    @State var products: [AdaptyPaywallProduct] = []
    @State var hasLoaded: Bool = false
    @State var overlay: Bool = false
    @State var showSucceededAlert: Bool = false
    @State var showFailedAlert: Bool = false
    @State var showPurchaseFailedAlert: Bool = false
    @State var showFreeTrialAlert: Bool = false
    var body: some View {
        ZStack {
            if !hasLoaded {
                ProgressView()
            } else {
                paywallPage
            }
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding(20)
                    Spacer()
                }
            }
        }
        .task {
            if let products = await AdaptyManager.shared.getProducts() {
                self.products = products
                hasLoaded = true
            }
        }
        .alert("Restore Succeeded", isPresented: $showSucceededAlert) {
            Button(role: .cancel, action: {
                dismiss()
            }) {
                Text("OK")
            }
        }
        .alert("Restore Failed", isPresented: $showFailedAlert) {
            Button(role: .cancel, action: {}) {
                Text("OK")
            }
        }
        .alert("Purchase Failed", isPresented: $showPurchaseFailedAlert) {
            Button(role: .cancel, action: {}) {
                Text("OK")
            }
        }
        .alert("Activate 10 Day Free Trial?", isPresented: $showFreeTrialAlert) {
            Button(role: .none, action: {
                Task {
                    await subManager.setUpFreeTrial()
                    dismiss()
                }
            }) {
                Text("Yes")
            }
            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
        }
    }
    
    var paywallPage: some View {
        ScrollView {
            VStack {
                Text("ConvertTiles Pro")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                iconImageSection
                advantagesSection
                buttonSection
                    .padding(.vertical, 20)
                informationSection
                HStack {Spacer()}
            }
            .padding(.top, 50)
        }
        .background(Color(red: 0.261, green: 0.261, blue: 0.261))
        .overlay {
            if overlay {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea(.all)
                    ProgressView()
                }
            }
        }
    }
    
    var iconImageSection: some View {
        ZStack {
            Image("Icon")
                .resizable()
                .frame(width: 160, height: 160)
                .cornerRadius(35)
            Text("Pro")
                .foregroundColor(.white)
                .font(.system(size: 60))
                .fontDesign(.monospaced)
                .fontWeight(.bold)
                .rotationEffect(.degrees(335))
        }
        .frame(height: 140)
        .padding(.bottom, 20)
    }
    
    var advantagesSection: some View {
        VStack(alignment: .leading) {
            Text("Pro gets you:")
                .foregroundColor(.white)
                .font(.system(size: 26))
            Group {
                Text("-many more converter options")
                    .foregroundColor(.teal)
                Text("-ability to edit tiles")
                    .foregroundColor(.red)
                Text("-light or dark mode options")
                    .foregroundColor(.black)
                Text("-more than four converters at a time")
                    .foregroundColor(.green)
                Text("-infinite color options")
                    .foregroundColor(.purple)
                Text("-accent lines around the tiles")
                    .foregroundColor(.orange)
                Text("-support further app development")
                    .foregroundColor(.blue)
                Text("-one time purchase")
                    .foregroundColor(.white)
            }
            .font(.system(size: 19))
        }
    }
    
    var buttonSection: some View {
        VStack(spacing: 15) {
            freeTrialSection
            // Purchase Button
            ForEach(products, id: \.localizedTitle) { product in
                Button(action: {
                    overlay = true
                    Task {
                        if await subManager.makePurchase(product: product) {
                            overlay = false
                            dismiss()
                        } else {
                            showPurchaseFailedAlert.toggle()
                            overlay = false
                            
                        }
                    }
                }) {
                    ZStack {
                        VStack {
                            Spacer()
                            Text("Lifetime Purchase")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            HStack {
                                Spacer()
                                Text("Buy now:")
                                    .font(.system(size: 19))
                                    .foregroundColor(.green)
                                Spacer()
                                Text(product.localizedPrice!)
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                            Spacer()
                        }
                        .frame(width: 305, height: 55)
                        .background(Color.black)
                        .cornerRadius(9)
                    }
                    .frame(width: 310, height: 60)
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }
            
            // Restore Button
            Button(action: {
                Task {
                    overlay = true
                    if await subManager.restorePurchase() {
                        showSucceededAlert.toggle()
                        overlay = false
                    } else {
                        showFailedAlert.toggle()
                        overlay = false
                    }
                }
            }) {
                ZStack {
                    Text("Restore Purchase")
                        .foregroundColor(.red)
                        .frame(width: 305, height: 30)
                        .background(Color.black)
                        .cornerRadius(8)
                        .fontDesign(.serif)
                        .font(.title3)
                }
                .frame(width: 310, height: 35)
                .background(Color.green)
                .cornerRadius(10)
            }
        }
    }
    
    var freeTrialSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if subManager.trialStatus == .unused {
                Text("Try it for Free...")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .italic()
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                Button(action: {
                    showFreeTrialAlert.toggle()
                }) {
                    ZStack {
                        VStack {
                            Text("10 Day Free Trial")
                                .foregroundStyle(.black)
                                .fontDesign(.monospaced)
                                .font(.title2)
                            Text("Once trial is over you can purchase Pro separately.")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                        }
                        .frame(width: 300, height: 50)
                        .background(.blue)
                        .cornerRadius(5)
                    }
                    .frame(width: 310, height: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                Text("or buy it now:")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .italic()
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
            } else if subManager.trialStatus == .inUse{
                Text("Days left in free trial: "+"\(subManager.daysLeft)")
                    .foregroundStyle(.orange)
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                Text("or buy it now:")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .italic()
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
            } else if subManager.trialStatus == .used {
                Text("Buy now to unlock Pro features:")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .italic()
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var informationSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Payment will be charged to Apple ID Account at confirmation of purchase.")
                .font(.system(size: 12))
                .foregroundColor(.white)
            Text("Free trial is one per device. When it is up you will need to purchase Pro to keep all features unlocked.")
                .font(.system(size: 12))
                .foregroundColor(.white)
            Link("Contact Info and Privacy Policy", destination: URL(string: "https://jasonkoehn.github.io/converttiles")!)
                .foregroundColor(.blue)
                .font(.system(size: 12))
        }
        .frame(width: 310)
    }
}
