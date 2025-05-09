# RoboCards iOS App Development Prompt

## App Overview
Create a toddler-focused flashcard iOS app called "RoboCards" that displays educational flashcards with images and words in three languages (English, Mandarin, and Cantonese). The app will use Apple's text-to-speech functionality to pronounce words when language buttons are tapped.

## Key Features
1. **Flashcard Display System**: Create a main view that displays flashcards with clear images and corresponding words.
2. **Multilingual Audio Support**: Implement functionality for three language buttons (English, Mandarin, and Cantonese flags) that trigger text-to-speech in the selected language.
3. **Category Navigation**: Create a side menu with 16 educational categories (Common Nouns, Animals, Body Parts, etc.) that users can select to view different flashcard sets.
4. **UI Components**: Light blue background, navigation menu button, settings button, animated card transitions, and responsive side menu.

## Technical Requirements
- **Platform**: iOS 16.0+ (iPhone and iPad compatible)
- **Development Language**: Swift 5.9+
- **UI Framework**: SwiftUI for modern, responsive interface
- **Architecture**: MVVM (Model-View-ViewModel) for clean separation of concerns
- **Data Storage**: Local JSON or Core Data for flashcard content
- **APIs**: AVFoundation for text-to-speech functionality
- **Accessibility**: VoiceOver support and other accessibility features

## App Structure
1. **Models**:
   - `FlashcardModel`: Contains image reference, word in multiple languages
   - `CategoryModel`: Contains category name, icon, and associated flashcards

2. **Views**:
   - `MainView`: Root view containing the navigation structure
   - `FlashcardView`: Displays the current flashcard with word and image
   - `CategorySideMenu`: Side menu showing all 16 categories with icons
   - `LanguageButtonsView`: Contains the three language flag buttons
   - `SettingsView`: App configuration options

3. **ViewModels**:
   - `FlashcardViewModel`: Manages flashcard data and text-to-speech functionality
   - `CategoryViewModel`: Handles category selection and filtering

## Detailed Requirements

### Flashcard Display
- Display a single flashcard centered on screen
- Show a clear image representing the concept
- Display the word below the image in large, child-friendly font
- Include a play button for auto-pronunciation
- Implement swipe gestures to navigate between cards

### Language Support
- Implement three language buttons with corresponding flags (US, China, Hong Kong)
- When a language button is tapped, pronounce the word using AVSpeechSynthesizer
- Support appropriate voice selection for each language
- Store translations for all words in the three supported languages

### Category System
- Implement all 16 categories as specified:
  1. Common Nouns
  2. People
  3. Body Parts
  4. Animals
  5. Food and Drink
  6. Clothing
  7. Toys and Play
  8. Colors
  9. Numbers
  10. Shapes
  11. Transportations
  12. Actions (Verbs)
  13. Descriptive Words (Adjectives)
  14. Prepositions
  15. Pronouns
  16. Question Words
- Each category should have a distinct icon and at least 6 flashcards
- Allow for easy navigation between categories

### UI/UX Design
- Light blue background (#D4F1F9 or similar) for the main interface
- Clean, child-friendly typography (rounded sans-serif fonts)
- Smooth animations for card transitions and menu sliding
- Hamburger menu icon in top-left for category navigation
- Settings gear icon in top-right
- Side menu that slides in from the left, pushing the card view to the right
- Appropriate padding and spacing for all elements

### Text-to-Speech Implementation
- Use AVSpeechSynthesizer for text-to-speech functionality
- Configure appropriate voices for each language:
  - English: en-US
  - Mandarin: zh-CN
  - Cantonese: zh-HK
- Implement proper error handling if voices are unavailable
- Optimize speech rate and pitch for toddler comprehension

### Data Management
- Create a structured JSON file containing all flashcard data
- Implement efficient loading and caching of images
- Support for future content updates

### Settings and Preferences
- Volume control for speech
- Speech rate adjustment
- Option to auto-play pronunciation when new card appears
- Enable/disable specific languages
- Reset progress option

## Sample Code Structure
Please implement this app using a clean MVVM architecture. Start by creating:

1. The data models for flashcards and categories
2. The main UI layout with flashcard display
3. The side menu for category selection
4. The language button functionality with text-to-speech
5. Navigation and state management

## Design Notes
- Use child-friendly, rounded UI elements
- Ensure large tap targets for small fingers
- Keep the interface simple and uncluttered
- Use bright, engaging colors for category icons
- Implement subtle animations to maintain engagement

## Future Considerations
- User accounts for progress tracking
- Parental controls and usage statistics
- Additional language support
- Custom flashcard creation
- Quiz/game modes to test learning