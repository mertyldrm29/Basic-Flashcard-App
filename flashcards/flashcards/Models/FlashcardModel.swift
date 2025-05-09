import Foundation

struct FlashcardModel: Identifiable, Codable {
    let id: UUID
    let imageName: String
    let translations: [Language: String]
    let category: Category
    
    enum Language: String, Codable {
        case english = "en"
        case mandarin = "zh-CN"
        case cantonese = "zh-HK"
        
        var flag: String {
            switch self {
            case .english: return "🇺🇸"
            case .mandarin: return "🇨🇳"
            case .cantonese: return "🇭🇰"
            }
        }
    }
    
    enum Category: String, Codable, CaseIterable {
        case commonNouns = "Common Nouns"
        case people = "People"
        case bodyParts = "Body Parts"
        case animals = "Animals"
        case foodAndDrink = "Food and Drink"
        case clothing = "Clothing"
        case toysAndPlay = "Toys and Play"
        case colors = "Colors"
        case numbers = "Numbers"
        case shapes = "Shapes"
        case transportation = "Transportation"
        case actions = "Actions"
        case descriptiveWords = "Descriptive Words"
        case prepositions = "Prepositions"
        case pronouns = "Pronouns"
        case questionWords = "Question Words"
        
        var icon: String {
            switch self {
            case .commonNouns: return "textformat"
            case .people: return "person.2"
            case .bodyParts: return "figure.stand"
            case .animals: return "pawprint"
            case .foodAndDrink: return "fork.knife"
            case .clothing: return "tshirt"
            case .toysAndPlay: return "gamecontroller"
            case .colors: return "paintpalette"
            case .numbers: return "number"
            case .shapes: return "square.on.circle"
            case .transportation: return "car"
            case .actions: return "figure.walk"
            case .descriptiveWords: return "text.bubble"
            case .prepositions: return "arrow.up.right"
            case .pronouns: return "person.text.rectangle"
            case .questionWords: return "questionmark.circle"
            }
        }
    }
} 