import SwiftUI

// Bagian ini sekarang hanya untuk TAMPILAN, tidak ada interaksi.
struct KalkulatorInputRoww: View {
    let namaKomponen: String
    let persentase: Int
    let nilaiAktual: String        // Diubah dari @Binding menjadi let (data tetap)
    let skorMinimumTampil: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(namaKomponen) (\(persentase)%)")
                    .fontWeight(.semibold)
                Spacer()
                Text("Minimum Score")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            HStack {
                TextField("Nilai Aktual", text: .constant(nilaiAktual))
                    .disabled(false)
                // Menonaktifkan input dari pengguna
                    .padding(10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                Spacer()
                Text(skorMinimumTampil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(skorMinimumTampil == "❗️" ? .red : .green)
                    .frame(width: 100, alignment: .trailing)
            }
        }
        .padding(.vertical, 10)
    }
}

// Tampilan utama yang semua datanya sudah di-hardcode (statis)
struct KalkulatorNilaiVieww: View {
    // MARK: - Data Statis (Hardcoded)
    // Semua data @State diganti dengan let (konstanta)
    let gradeOptions = ["Pilih Grade", "A", "AB", "B", "BC", "C", "D", "E"]
    let bobot: [String: Int] = ["Task": 15, "Quiz": 20, "Practicum": 15, "Mid": 20, "Final": 30]
    
    // Nilai-nilai ini sekarang ditetapkan secara permanen untuk ditampilkan
    let selectedGrade: String = "A"
    let nilaiTask: String = "90"
    let nilaiQuiz: String = "85"
    let nilaiPracticum: String = "" // Dibuat kosong untuk contoh
    let nilaiMid: String = "88"
    let nilaiFinal: String = ""     // Dibuat kosong untuk contoh
    
    let minSkorTask: String = "-"
    let minSkorQuiz: String = "-"
    let minSkorPracticum: String = "75.5" // Contoh nilai minimum
    let minSkorMid: String = "-"
    let minSkorFinal: String = "75.5"     // Contoh nilai minimum
    
    let summaryText: String = "Ini adalah tampilan statis dari kalkulator nilai."

    // MARK: - Body View (Hanya Tampilan)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Components")
                    .font(.largeTitle).fontWeight(.bold)
                HStack {
                    Text("Predict Grade").fontWeight(.medium)
                    Spacer()
                    // Picker dinonaktifkan, hanya menampilkan nilai yang sudah dipilih
                    Picker("Grade", selection: .constant(selectedGrade)) {
                        ForEach(gradeOptions, id: \.self) { Text($0) }
                    }
                    .disabled(true) // Menonaktifkan picker
                }
                .padding(.bottom, 10)
                
                // Semua baris input sekarang hanya menampilkan data statis di atas
                KalkulatorInputRoww(namaKomponen: "Task", persentase: bobot["Task"]!, nilaiAktual: nilaiTask, skorMinimumTampil: minSkorTask)
                Divider()
                KalkulatorInputRoww(namaKomponen: "Quiz", persentase: bobot["Quiz"]!, nilaiAktual: nilaiQuiz, skorMinimumTampil: minSkorQuiz)
                Divider()
                KalkulatorInputRoww(namaKomponen: "Practicum", persentase: bobot["Practicum"]!, nilaiAktual: nilaiPracticum, skorMinimumTampil: minSkorPracticum)
                Divider()
                KalkulatorInputRoww(namaKomponen: "Mid", persentase: bobot["Mid"]!, nilaiAktual: nilaiMid, skorMinimumTampil: minSkorMid)
                Divider()
                KalkulatorInputRoww(namaKomponen: "Final", persentase: bobot["Final"]!, nilaiAktual: nilaiFinal, skorMinimumTampil: minSkorFinal)
                
                // Teks ringkasan statis
                if !summaryText.isEmpty {
                    Text(summaryText)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
            }
            .padding()
        }
        .navigationTitle("Kalkulasi Nilai")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // SEMUA FUNGSI LOGIKA (calculateMinimumScores, resetCalculations) TELAH DIHAPUS
}

// Preview untuk KalkulatorNilaiView
#Preview {
    NavigationView {
        KalkulatorNilaiVieww()
    }
    
    
    
}
