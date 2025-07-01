import SwiftUI

struct KalkulatorInputRow: View {
    let namaKomponen: String
    let persentase: Int
    @Binding var nilaiAktual: String
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
                TextField("Nilai Aktual", text: $nilaiAktual)
                    .keyboardType(.decimalPad)
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

struct KalkulatorNilaiView: View {
    // MARK: - State Properties
    let gradeThresholds: [String: Double] = ["A": 79.5, "AB": 72, "B": 64.5, "BC": 57, "C": 49.5, "D": 34, "E": 0]
    let gradeOptions = ["Pilih Grade", "A", "AB", "B", "BC", "C", "D", "E"]
    let bobot: [String: Int] = ["Task": 15, "Quiz": 20, "Practicum": 15, "Mid": 20, "Final": 30]
    
    @FocusState private var focusedField: String?
    @State private var selectedGrade: String = "Pilih Grade"
    @State private var nilaiTask: String = ""
    @State private var nilaiQuiz: String = ""
    @State private var nilaiPracticum: String = ""
    @State private var nilaiMid: String = ""
    @State private var nilaiFinal: String = ""
    @State private var minSkorTask: String = "-"
    @State private var minSkorQuiz: String = "-"
    @State private var minSkorPracticum: String = "-"
    @State private var minSkorMid: String = "-"
    @State private var minSkorFinal: String = "-"
    @State private var summaryText: String = "Silakan pilih target grade untuk memulai kalkulasi."

    // MARK: - Body View
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("punya TI")
                        .font(.largeTitle).fontWeight(.bold)
                    HStack {
                        Text("Predict Grade").fontWeight(.medium)
                        Spacer()
                        Picker("Grade", selection: $selectedGrade) {
                            ForEach(gradeOptions, id: \.self) { Text($0) }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    KalkulatorInputRow(namaKomponen: "Task", persentase: bobot["Task"]!, nilaiAktual: $nilaiTask, skorMinimumTampil: minSkorTask)
                        .focused($focusedField, equals: "Task").id("Task")
                    Divider()
                    KalkulatorInputRow(namaKomponen: "Quiz", persentase: bobot["Quiz"]!, nilaiAktual: $nilaiQuiz, skorMinimumTampil: minSkorQuiz)
                        .focused($focusedField, equals: "Quiz").id("Quiz")
                    Divider()
                    KalkulatorInputRow(namaKomponen: "Practicum", persentase: bobot["Practicum"]!, nilaiAktual: $nilaiPracticum, skorMinimumTampil: minSkorPracticum)
                        .focused($focusedField, equals: "Practicum").id("Practicum")
                    Divider()
                    KalkulatorInputRow(namaKomponen: "Mid", persentase: bobot["Mid"]!, nilaiAktual: $nilaiMid, skorMinimumTampil: minSkorMid)
                        .focused($focusedField, equals: "Mid").id("Mid")
                    Divider()
                    KalkulatorInputRow(namaKomponen: "Final", persentase: bobot["Final"]!, nilaiAktual: $nilaiFinal, skorMinimumTampil: minSkorFinal)
                        .focused($focusedField, equals: "Final").id("Final")
                    
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
            .onChange(of: focusedField) { oldValue, newValue in
                if let fieldID = newValue {
                    withAnimation { proxy.scrollTo(fieldID, anchor: .bottom) }
                }
            }
        }
        .navigationTitle("Kalkulasi Nilai")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut, value: summaryText)
        .onChange(of: selectedGrade) { _, _ in calculateMinimumScores() }
        .onChange(of: nilaiTask) { _, _ in calculateMinimumScores() }
        .onChange(of: nilaiQuiz) { _, _ in calculateMinimumScores() }
        .onChange(of: nilaiPracticum) { _, _ in calculateMinimumScores() }
        .onChange(of: nilaiMid) { _, _ in calculateMinimumScores() }
        .onChange(of: nilaiFinal) { _, _ in calculateMinimumScores() }
        .onAppear(perform: calculateMinimumScores)
    }
    
    // MARK: - Calculation Logic
    private func calculateMinimumScores() {
        guard selectedGrade != "Pilih Grade",
              let targetTotalScore = gradeThresholds[selectedGrade] else {
            resetCalculations()
            return
        }
        let nilaiInput: [String: String] = ["Task": nilaiTask, "Quiz": nilaiQuiz, "Practicum": nilaiPracticum, "Mid": nilaiMid, "Final": nilaiFinal]
        var komponenKosong: [String] = []
        var nilaiTertimbangTerkumpul: Double = 0
        for (komponen, bobot) in self.bobot {
            if let nilaiStr = nilaiInput[komponen], let nilai = Double(nilaiStr), !nilaiStr.isEmpty {
                nilaiTertimbangTerkumpul += (nilai * Double(bobot)) / 100.0
            } else {
                komponenKosong.append(komponen)
            }
        }
        if komponenKosong.isEmpty {
            let totalNilaiAkhir = nilaiTertimbangTerkumpul
            var gradeDidapat = "E"
            for (grade, threshold) in gradeThresholds.sorted(by: { $0.value > $1.value }) {
                if totalNilaiAkhir >= threshold { gradeDidapat = grade; break }
            }
            let nilaiFormatted = String(format: "%.2f", totalNilaiAkhir)
            summaryText = "Nilai akhir kamu adalah \(nilaiFormatted) dengan grade \(gradeDidapat)."
            minSkorTask = "-"; minSkorQuiz = "-"; minSkorPracticum = "-"; minSkorMid = "-"; minSkorFinal = "-"
        } else {
            var totalBobotKosong: Double = 0
            for komponen in komponenKosong { totalBobotKosong += Double(self.bobot[komponen]!) }
            let sisaNilaiDibutuhkan = targetTotalScore - nilaiTertimbangTerkumpul
            var skorMinimum: Double = 0
            if totalBobotKosong > 0 { skorMinimum = (sisaNilaiDibutuhkan / totalBobotKosong) * 100.0 }
            let displayValue: String
            if sisaNilaiDibutuhkan <= 0 { displayValue = "✅" }
            else if skorMinimum > 100 { displayValue = "❗️" }
            else if skorMinimum < 0 { displayValue = "✅" }
            else { displayValue = String(format: "%.1f", skorMinimum) }
            minSkorTask = nilaiTask.isEmpty ? displayValue : "-"
            minSkorQuiz = nilaiQuiz.isEmpty ? displayValue : "-"
            minSkorPracticum = nilaiPracticum.isEmpty ? displayValue : "-"
            minSkorMid = nilaiMid.isEmpty ? displayValue : "-"
            minSkorFinal = nilaiFinal.isEmpty ? displayValue : "-"
            summaryText = "Untuk mencapai grade \(selectedGrade), isi nilai aktual untuk melihat nilai minimum rata-rata yang dibutuhkan pada komponen lainnya."
        }
    }
    
    private func resetCalculations() {
        minSkorTask = "-"
        minSkorQuiz = "-"
        minSkorPracticum = "-"
        minSkorMid = "-"
        minSkorFinal = "-"
        summaryText = "Silakan pilih target grade untuk memulai kalkulasi."
    }
}

// Preview untuk KalkulatorNilaiView
#Preview {
    KalkulatorNilaiView()
}
