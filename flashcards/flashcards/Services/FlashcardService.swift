import Foundation

enum FlashcardError: Error {
    case fileNotFound
    case decodingError
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return "Flashcard data file not found"
        case .decodingError:
            return "Error decoding flashcard data"
        case .invalidData:
            return "Invalid flashcard data format"
        }
    }
}

actor FlashcardService {
    static let shared = FlashcardService()
    
    private init() {}
    
    func loadFlashcards() async throws -> [FlashcardModel] {
        guard let url = Bundle.main.url(forResource: "flashcards", withExtension: "json") else {
            throw FlashcardError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(FlashcardResponse.self, from: data)
            
            return response.flashcards.map { flashcard in
                FlashcardModel(
                    id: UUID(uuidString: flashcard.id) ?? UUID(),
                    imageName: flashcard.imageName,
                    translations: [
                        .english: flashcard.translations["en"] ?? "",
                        .mandarin: flashcard.translations["zh-CN"] ?? "",
                        .cantonese: flashcard.translations["zh-HK"] ?? ""
                    ],
                    category: FlashcardModel.Category(rawValue: flashcard.category) ?? .commonNouns
                )
            }
        } catch {
            throw FlashcardError.decodingError
        }
    }
}

// Response models for JSON decoding
private struct FlashcardResponse: Codable {
    let flashcards: [FlashcardData]
}

private struct FlashcardData: Codable {
    let id: String
    let imageName: String
    let translations: [String: String]
    let category: String
} 