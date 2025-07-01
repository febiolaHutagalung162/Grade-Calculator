import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    
    // MEMBACA DATA YANG TERSIMPAN
    @AppStorage("userMajor") var userMajor: String = ""
    @AppStorage(    "userSemester") var userSemester: String = ""
    
    @State private var isShowingPopup = false
    @State private var selectedCourseTitle = ""
    @State private var navigateToCalculator = false

    let courses = [
        ("Dasar Pemrograman", Color.orange),
        ("Pengembangan Aplikasi Mobile", Color.blue),
        ("Matematika Dasar I", Color.green),
        ("Basis Data", Color.purple),
        ("Aljabar Linier", Color.red),
        ("Jaringan Komputer", Color.teal)
    ]
    
    let gridLayout: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6).ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Image(systemName: "graduationcap.fill").font(.largeTitle).foregroundStyle(Color.accentColor)
                                Text("gator").font(.headline).fontWeight(.bold)
                            }
                            Spacer()
                            // Tombol untuk reset pilihan (berguna untuk testing)
                            Button("Reset Pilihan") {
                                userMajor = ""
                                userSemester = ""
                            }
                            .font(.caption)
                            .buttonStyle(.bordered)
                        }
                        
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(.gray)
                            TextField("Search...", text: $searchText)
                            Image(systemName: "mic.fill").foregroundColor(.gray)
                        }
                        .padding(12).background(Color.white).cornerRadius(10)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                        
                        // MENAMPILKAN DATA DARI @AppStorage
                        Text("Hi, **\(userMajor)**!\nWelcome to grade Kalkulator IT Del!")
                            .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                            .padding().background(Color.white).cornerRadius(10)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                        
                        HStack {
                            // MENAMPILKAN DATA DARI @AppStorage
                            Text("Semester : \(userSemester)")
                                .font(.headline).fontWeight(.semibold)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "xmark").font(.subheadline).padding(5)
                                    .background(Color.gray.opacity(0.2)).clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        
                        LazyVGrid(columns: gridLayout, spacing: 16) {
                            ForEach(courses, id: \.0) { course in
                                CourseButton(title: course.0, color: course.1) {
                                    selectedCourseTitle = course.0
                                    isShowingPopup = true
                                }
                            }
                            
                        }
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                       
                        
                        Text("Made by Kelompok 1 (Mic)")
                            .font(.caption).foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                        
                    }
                    .padding()
                }
                
                if isShowingPopup {
                    CoursePopupView(
                        courseTitle: selectedCourseTitle,
                        isShowing: $isShowingPopup,
                        onCalculateTapped: {
                            isShowingPopup = false
                            navigateToCalculator = true
                        }
                    )
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToCalculator) {
                KalkulatorNilaiView()
            }
        }
    }
}


struct CourseButton: View {
    let title: String
    let color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline).fontWeight(.bold).foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 80).padding(8)
                .background(color).cornerRadius(15)
                .shadow(color: color.opacity(0.4), radius: 5, y: 5)
        }
    }
}

// Preview untuk HomeView
#Preview {
    ContentView()
}
