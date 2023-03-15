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
                overlay = false
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
    
    // MARK: Paywall Page
    var paywallPage: some View {
        ScrollView {
            VStack {
                Text("ConvertTiles Pro")
                    .font(.system(size: 40))
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                iconImageSection
                advantagesSection

                buttonSection
                    .padding(.vertical, 20)
                HStack {Spacer()}

            }
            .padding(.top, 50)
        }
        .background(Color(red: 0.261, green: 0.261, blue: 0.261))
        .overlay {
            if overlay {
                ZStack {
                    Color.black.opacity(0.6).ignoresSafeArea(.all)
                    ProgressView()
                }
            }
        }
    }
    
    // MARK: Image Section
    var iconImageSection: some View {
        ZStack {
            Image("Icon")
                .resizable()
                .frame(width: 160, height: 160)
                .cornerRadius(35)
            Text("Pro")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .fontDesign(.monospaced)
                .fontWeight(.bold)
                .rotationEffect(.degrees(335))
        }
        .frame(height: 140)
        .padding(.bottom, 20)
    }
    
    // MARK: Adavatages Section
    var advantagesSection: some View {
        VStack(alignment: .leading) {
            Text("Pro gets you:")
                .font(.system(size: 26))
                .foregroundColor(.white)
            Group {
                Text("-many more converter options")
                    .foregroundColor(.teal)
                Text("-ability to edit tiles")
                    .foregroundColor(.red)
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
    
    // MARK: Button Section
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
                        Text("1 week free trial")
                            .italic()
                            .font(.system(size: 17))
                            .foregroundColor(.white)
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
                    if await AdaptyManager.shared.restorePurchases() {
                        pro = true
                        showSucceededAlert.toggle()
                    } else {
                        overlay = false
                        showFailedAlert.toggle()
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
    
    // MARK: Information Section
    var informationSection: some View {
        Text("")
    }
}
