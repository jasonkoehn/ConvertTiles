//
//  AppIconSwift.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 3/1/23.
//

import SwiftUI

struct AppIconSwift: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 650, height: 650)
                .foregroundColor(.white)
            ZStack {
                Rectangle()
                    .frame(width: 600, height: 600)
                    .foregroundColor(.black)
                VStack {
                    HStack {
                        TileView(color: Color(red: 255/255, green: 38/255, blue: 0/255, opacity: 0.9), name: "thermometer.medium", rotated: false, size: 90)
                        
                        TileView(color: Color(red: 0/255, green: 200/255, blue: 0/255, opacity: 0.86), name: "ruler", rotated: true, size: 85)
                    }
                    HStack {
                        TileView(color: Color(red: 0/255, green: 145/255, blue: 145/255, opacity: 1), name: "fuelpump.fill", rotated: false, size: 90)
                        
                        TileView(color: Color(red: 255/255, green: 147/255, blue: 0/255, opacity: 0.9), name: "bolt.fill", rotated: false, size: 90)
                    }
                    HStack {
                        TileView(color: Color(red: 175/255, green: 67/255, blue: 235/255, opacity: 1), name: "angle", rotated: false, size: 110)
                        
                        TileView(color: Color(red: 0/255, green: 110/255, blue: 255/255, opacity: 1), name: "scalemass.fill", rotated: false, size: 95)
                    }
                }
            }
        }
    }
    struct TileView: View {
        var color: Color
        var name: String
        var rotated: Bool
        var size: CGFloat
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 222, height: 120)
                    .foregroundColor(Color(red: 0.267, green: 0.267, blue: 0.267))
                    .cornerRadius(16)
                Image(systemName: name)
                    .font(.system(size: size))
                    .foregroundColor(color)
                    .rotationEffect(.degrees(rotated ? 270 : 0))
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 15)
        }
    }
}

struct AppIconSwift_Previews: PreviewProvider {
    static var previews: some View {
        AppIconSwift()
    }
}
