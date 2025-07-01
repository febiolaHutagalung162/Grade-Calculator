//
//  Grade_CalculatorApp.swift
//  Grade Calculator
//
//  Created by Foundation-009 on 20/06/25.
//

import SwiftUI

@main
struct Grade_CalculatorApp: App {
    // Membaca data yang tersimpan di perangkat.
    // Jika tidak ada data, nilai default-nya adalah string kosong "".
    @AppStorage("userMajor") var userMajor: String = ""
    @AppStorage("userSemester") var userSemester: String = ""

    var body: some Scene {
        WindowGroup {
            // Logika untuk memilih tampilan awal
            if userMajor.isEmpty || userSemester.isEmpty {
                // Jika jurusan atau semester belum dipilih, tampilkan halaman pemilihan.
                ChooseYourView()
            } else {
                // Jika sudah pernah dipilih, langsung tampilkan homepage.
                HomeView()
            }
        }
    }
}
