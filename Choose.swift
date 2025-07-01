import SwiftUI

struct ChooseYourView: View {
    // DAFTAR PILIHAN
    // Kita hapus placeholder dari sini agar hanya pilihan valid yang bisa disimpan.
    let majorOptions = ["Informatika", "Sistem Informasi", "Teknik Elektro"]
    let semesterOptions = ["1", "2", "3", "4", "5", "6", "7", "8"]

    // MENGGUNAKAN @AppStorage untuk menyimpan pilihan secara otomatis
    @AppStorage("userMajor") var selectedMajor: String = ""
    @AppStorage("userSemester") var selectedSemester: String = ""
    
    // State lokal untuk menandakan tombol ditekan
    @State private var isNextTapped = false

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 25) {
                Text("Choose Your:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                // Dropdown untuk Jurusan
                Picker("Pilih Jurusan", selection: $selectedMajor) {
                    // Teks placeholder yang tidak bisa dipilih
                    Text("Major/Diploma").tag("")
                    ForEach(majorOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .tint(selectedMajor.isEmpty ? .gray : .primary)

                // Dropdown untuk Semester
                Picker("Pilih Semester", selection: $selectedSemester) {
                    Text("Semester").tag("")
                    ForEach(semesterOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .tint(selectedSemester.isEmpty ? .gray : .primary)

                Spacer()

                // Tombol Next
                Button(action: {
                    // Tidak perlu melakukan apa-apa lagi di sini,
                    // karena @AppStorage sudah menyimpan nilainya.
                    // Saat aplikasi di-restart, ia akan membuka HomeView.
                    // Untuk efek langsung, kita bisa menggunakan state lain jika perlu.
                    // Tapi pendekatan paling sederhana adalah membiarkan App struct yang handle.
                    
                    // Untuk demonstrasi, kita anggap tombol ini "mengunci" pilihan.
                    // Dalam praktiknya, cukup memilih dari picker saja sudah cukup.
                    print("Pilihan disimpan!")
                }) {
                    Text("Next")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                // Tombol akan nonaktif jika salah satu pilihan belum diisi
                .disabled(selectedMajor.isEmpty || selectedSemester.isEmpty)
            }
            .padding(30)
            .frame(width: 350, height: 400)
            .background(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    ChooseYourView()
}
