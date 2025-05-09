import SwiftUI

struct FlashcardView: View {
    @StateObject private var viewModel = FlashcardViewModel()
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Color(red: 0.83, green: 0.95, blue: 0.98) // Light blue background
                .ignoresSafeArea()
            
            VStack {
                // Top Bar
                HStack {
                    Button(action: { viewModel.toggleMenu() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                Spacer()
                
                // Flashcard
                if let flashcard = viewModel.currentFlashcard {
                    VStack(spacing: 20) {
                        Image(flashcard.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                        
                        Text(flashcard.translations[.english] ?? "")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 15)
                    .padding()
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation
                                isDragging = true
                            }
                            .onEnded { gesture in
                                withAnimation {
                                    if gesture.translation.width > 100 {
                                        viewModel.previousCard()
                                    } else if gesture.translation.width < -100 {
                                        viewModel.nextCard()
                                    }
                                    offset = .zero
                                    isDragging = false
                                }
                            }
                    )
                } else if viewModel.error != nil {
                    VStack(spacing: 20) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                        
                        Text("Error loading flashcards")
                            .font(.title2)
                            .foregroundColor(.red)
                        
                        Button("Try Again") {
                            Task {
                                await viewModel.loadFlashcards()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                
                Spacer()
                
                // Language Buttons
                if viewModel.currentFlashcard != nil {
                    HStack(spacing: 30) {
                        ForEach([FlashcardModel.Language.english,
                                .mandarin,
                                .cantonese], id: \.self) { language in
                            Button(action: { viewModel.speakWord(in: language) }) {
                                Text(language.flag)
                                    .font(.system(size: 40))
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            
            // Side Menu
            if viewModel.isMenuVisible {
                CategorySideMenu(
                    selectedCategory: viewModel.currentCategory,
                    onSelect: viewModel.selectCategory
                )
                .transition(.move(edge: .leading))
            }
        }
        .animation(.spring(), value: viewModel.isMenuVisible)
    }
}

struct CategorySideMenu: View {
    let selectedCategory: FlashcardModel.Category
    let onSelect: (FlashcardModel.Category) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Categories")
                .font(.title)
                .bold()
                .padding(.top)
            
            ForEach(FlashcardModel.Category.allCases, id: \.self) { category in
                Button(action: { onSelect(category) }) {
                    HStack {
                        Image(systemName: category.icon)
                            .font(.title2)
                        Text(category.rawValue)
                            .font(.title3)
                    }
                    .foregroundColor(category == selectedCategory ? .blue : .primary)
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 250)
        .background(Color.white)
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Speech Settings")) {
                    VStack {
                        Text("Speech Rate")
                        Slider(value: $viewModel.speechRate, in: 0.1...1.0)
                    }
                    
                    Toggle("Auto-play on new card", isOn: $viewModel.isAutoPlayEnabled)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FlashcardView()
} 