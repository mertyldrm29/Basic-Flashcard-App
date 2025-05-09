import Foundation
import AVFoundation
import Combine

@MainActor
class FlashcardViewModel: ObservableObject {
    @Published private(set) var currentFlashcard: FlashcardModel?
    @Published private(set) var currentCategory: FlashcardModel.Category = .foodAndDrink
    @Published private(set) var isMenuVisible = false
    @Published private(set) var error: Error?
    @Published var speechRate: Float = 0.5
    @Published var isAutoPlayEnabled = false
    
    private let synthesizer = AVSpeechSynthesizer()
    private var allFlashcards: [FlashcardModel] = []
    private var flashcards: [FlashcardModel] = []
    private var currentIndex = 0
    
    init() {
        Task {
            await loadFlashcards()
        }
    }
    
    func toggleMenu() {
        isMenuVisible.toggle()
    }
    
    func selectCategory(_ category: FlashcardModel.Category) {
        currentCategory = category
        filterFlashcards()
        isMenuVisible = false
    }
    
    func speakWord(in language: FlashcardModel.Language) {
        guard let flashcard = currentFlashcard,
              let word = flashcard.translations[language] else { return }
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.rate = speechRate
        utterance.pitchMultiplier = 1.2
        
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    func nextCard() {
        guard !flashcards.isEmpty else { return }
        currentIndex = (currentIndex + 1) % flashcards.count
        currentFlashcard = flashcards[currentIndex]
        
        if isAutoPlayEnabled {
            speakWord(in: .english)
        }
    }
    
    func previousCard() {
        guard !flashcards.isEmpty else { return }
        currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
        currentFlashcard = flashcards[currentIndex]
        
        if isAutoPlayEnabled {
            speakWord(in: .english)
        }
    }
    
    func loadFlashcards() async {
        do {
            let loaded = try await FlashcardService.shared.loadFlashcards()
            allFlashcards = loaded
            filterFlashcards()
        } catch {
            self.error = error
        }
    }
    
    private func filterFlashcards() {
        flashcards = allFlashcards.filter { $0.category == currentCategory }
        currentIndex = 0
        currentFlashcard = flashcards.first
    }
} 
