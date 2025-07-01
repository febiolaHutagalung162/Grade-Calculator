//
//  PopUpView.swift
//  Grade Calculator
//
//  Created by Foundation-009 on 26/06/25.
//

import SwiftUI

struct popUp: View {
    
    @State private var showPopup = true

    let primaryGreen = Color(red: 0.0, green: 0.6, blue: 0.4)
    let secondaryGreen = Color(red: 0.7, green: 0.95, blue: 0.8)
    let lightGrayBackground = Color(.systemGray6)

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(primaryGreen)
                    Spacer()
                }
                .padding()

            }
            .background(Color.white)

            if showPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                GradePopup(showPopup: $showPopup)
                    .padding(.horizontal, 24)
            }
        }
        .preferredColorScheme(.light)
    }
}

struct GradePopup: View {
    @Binding var showPopup: Bool

    let components = [
        ("Task", "15%"),
        ("Quiz", "20%"),
        ("Practikum", "15%"),
        ("Mid", "20%"),
        ("Final", "30%")
    ]

    let primaryGreen = Color(red: 0.0, green: 0.6, blue: 0.4)
    let softRed = Color(red: 1.0, green: 0.45, blue: 0.45)
    let popupBackground = Color(.systemGray6)

    
    
    var namaMatakuliah: String = "Matematika Dasar 1"
    var grade: String = "Calculate Grade"

    
    
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("\(namaMatakuliah)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)

                Spacer()

                Button {
                    showPopup = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(softRed)
                }
            }

            TableView(components: components)

            Button(action: {
                // Aksi kalkulasi grade
            }) {
                Text("\(grade)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(primaryGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(popupBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(primaryGreen.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct TableView: View {
    let components: [(String, String)]
    let dividerColor = Color.gray.opacity(0.3)
    

    var component = "Komponen"
    var weight = "Weight"
    
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("\(component)")
                    .font(.headline) // lebih besar dari item
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)

                Text("\(weight)")
                    .font(.headline) // lebih besar dari item
                    .bold()
                    .frame(width: 60, alignment: .trailing)
                    .foregroundColor(.black)
            }

            Divider().background(dividerColor)

            ForEach(components, id: \.0) { item in
                HStack {
                    Text(item.0)
                        .font(.subheadline) // lebih kecil dari header
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)

                    Text(item.1)
                        .font(.subheadline) // lebih kecil dari header
                        .frame(width: 100, alignment: .trailing)
                        .foregroundColor(.black)
                }
                Divider().background(dividerColor)
            }
        }
    }
}

#Preview {
    popUp()
}
