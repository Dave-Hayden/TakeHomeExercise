# Recipe App - Fetch Take Home Exercise

## Steps to Run the App
1. Clone the repository from the provided source.
2. Open the project in Xcode (Ensure Xcode version is compatible with Swift 5+).
3. Select the appropriate scheme for the simulator or device.
4. Run the project by pressing the `Run` button or use the shortcut `Cmd + R`.
5. The app will fetch and display a list of recipes from the `RecipeService`.

## Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized:
1. **MVVM Architecture**: Ensured the project followed a clear and maintainable MVVM structure by implementing a `RecipeViewModel` that manages the data flow between views and services.
2. **User Interface**: Focused on a clean and responsive UI using SwiftUI for displaying recipe lists and details.
3. **Networking and Data Fetching**: Utilized a `RecipeService` to handle API calls, ensuring proper data fetching and error handling.
   
I chose these areas to ensure the project was well-structured, scalable, and provided a smooth user experience with asynchronous data loading.

## Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 10-12 hours on this project:
- **3-4 hours** on designing and implementing the core structure (models, view models, and services).
- **4 hours** on developing and refining the UI in SwiftUI, ensuring the layout is responsive across different screen sizes.
- **2 hours** on testing (unit tests, UI behavior).
- **1-2 hours** on reviewing and refining code for best practices and performance optimizations.

## Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- **Asynchronous API Calls**: I opted to keep the API calls simple and avoided using a third-party library like `Alamofire` for networking. This trade-off ensured reduced external dependencies but might have introduced more manual handling of network errors and response parsing.
- **Simple Design**: I kept the UI relatively simple without adding advanced animations or complex navigation, focusing more on functionality and maintainability due to time constraints.

## Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part could be the lack of advanced UI/UX enhancements such as animations or transition effects. Due to the time constraints, I opted to focus on functionality and code structure rather than intricate UI details.

## External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No external libraries were used. The project relies purely on Swift and SwiftUI, alongside native networking with `URLSession`.

## Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- I designed the `RecipeService` to simulate fetching data from an external API. The service could easily be extended to use real API endpoints or different data sources.
- The project could benefit from further enhancements such as caching data, pagination, and improved error handling for edge cases (e.g., no internet connection).