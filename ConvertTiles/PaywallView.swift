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
    @AppStorage("pro") var pro: Bool = false
    @State var products: [AdaptyPaywallProduct] = []
    @State var hasLoaded: Bool = false
    @State var overlay: Bool = false
    @State var showSucceededAlert: Bool = false
    @State var showFailedAlert: Bool = false
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
                Text("-cancel anytime")
                    .foregroundColor(.white)
            }
            .font(.system(size: 19))
        }
    }
    
    var buttonSection: some View {
        VStack(spacing: 15) {
            ForEach(products, id: \.localizedTitle) { product in
                Button(action: {
                    overlay = true
                    Task {
                        if await AdaptyManager.shared.makePurchase(product: product) {
                            pro = true
                            overlay = false
                            dismiss()
                        } else {
                            overlay = false
                        }
                    }
                }) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(product.localizedTitle+":")
                                .font(.system(size: 23))
                            Spacer()
                            Text(product.localizedPrice!+"/"+product.localizedDescription)
                                .font(.system(size: 20))
                            Spacer()
                        }
                        if product.introductoryOfferEligibility == .eligible {
                            Text("1 week free trial")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .italic()
                        }
                        Spacer()
                    }
                    .foregroundColor(.blue)
                    .frame(width: 310, height: 60)
                    .background(Color.black)
                    .cornerRadius(15)
                }
            }
            Button(action: {
                Task {
                    overlay = true
                    if await AdaptyManager.shared.restorePurchase() {
                        pro = true
                        showSucceededAlert.toggle()
                        overlay = false
                    } else {
                        showFailedAlert.toggle()
                        overlay = false
                    }
                }
            }) {
                Text("Restore Purchase")
                    .foregroundColor(.red)
                    .frame(width: 310, height: 35)
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
    }
    
    var informationSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("If canceled within trial period no charges are applied.")
                .font(.system(size: 15))
                .fontDesign(.monospaced)
                .padding(.bottom, 5)
            Group {
                Text("Payment will be charged to Apple ID Account at confirmation of purchase.")
                Text("Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.")
                Text("Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal.")
                Text("Subscriptions may be managed by the user and auto renewal may be turned off by going to the user's Account Settings after purchase.")
                Text("Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.")
            }
            .font(.system(size: 10))
            Link("Contact Info and Privacy Policy", destination: URL(string: "https://jasonkoehn.github.io/converttiles")!)
                .foregroundColor(.blue)
                .font(.system(size: 12))
        }
        .foregroundColor(.white)
        .frame(width: 310)
    }
}
