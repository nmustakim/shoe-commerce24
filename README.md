# shoe_commerce

A simple Mobile (Android & iOS) application for selling shoes.

Project Setup Instructions
Clone the repository: git clone https://github.com/nmustakim/projectname.git
Ensure Flutter is installed: Follow the Flutter installation guide here.
Install dependencies: Run flutter pub get.
Run the project: Use flutter run to start the app on your connected device or simulator.


Assumptions Made During Development

Efficient Data Structure Top-Down Approach: I assumed that employing efficient data structures , 
with a top-down design approach, would optimize performance and scalability.

Limiting Data Fetch at a Time: I assumed that limiting the amount of data fetched at a time, perhaps through pagination.

Responsive UI: I assumed the importance of creating a responsive user interface adaptable to various screen sizes and orientations. Initially planned to use Mediaquery later used screen util.

Efficient State Management Solution: I assumed the necessity of an efficient state management solution, such as Provider or Riverpod to manage states and update UI accordingly.

Code Reusability and Modularity: I assumed that structuring the codebase for reusability and modularity.

Error Handling: I assumed the significance of implementing robust error handling mechanisms to  manage unexpected errors and provide informative feedback to users.





User
Include a README in your repository explaining:
Project setup instructions.
Assumptions you made during development.
Challenges you faced and how you overcame them.
Any additional features or improvements you added.
what does  Assumptions you made during development. mean her?
ChatGPT
"Assumptions you made during development" refers to the expectations or beliefs you held while working on the project. These assumptions might involve aspects like the availability of certain resources, the behavior of external systems or users, or the interpretation of requirements. Including them in the README helps other developers understand the context in which the project was developed and how certain decisions were made.

Here's an example of what you might include in the README section on assumptions:

Assumptions Made During Development
User Authentication: We assumed that users will have valid credentials to access the system and that the authentication service will always be available.

Database Performance: We assumed that the database queries will perform adequately under expected user loads. However, we haven't tested the system under extreme loads.

Browser Compatibility: We assumed that the majority of users will access the application using modern web browsers and didn't prioritize extensive testing on older browser versions.

Third-party API Stability: We assumed that the third-party APIs we integrate with will maintain consistent behavior and won't introduce breaking changes without prior notice.

Localization: We assumed that the application will primarily be used in English-speaking regions and didn't prioritize extensive localization efforts for other languages.

These assumptions provide insights into the development process and the context in which the project was created, helping others understand the reasoning behind certain design choices or limitations.

My assumptions Efficient data structure top down approach. Limiting data fetch at a time, responsive ui. efficient state management solution provider code reusability and modularity Error handling...
ChatGPT
Those assumptions give a clear picture of your approach to development. Let's incorporate them into the README:

Assumptions Made During Development
Efficient Data Structure Top-Down Approach: We assumed that employing efficient data structures and algorithms, with a top-down design approach, would optimize performance and scalability.

Limiting Data Fetch at a Time: We assumed that limiting the amount of data fetched at a time, through pagination or other techniques, would enhance the application's responsiveness and reduce server load.

Responsive UI: We assumed the importance of a responsive user interface across various devices and screen sizes to ensure a seamless user experience.

Efficient State Management Solution: We assumed the necessity of an efficient state management solution, such as Redux or Context API in React, to manage application state effectively and avoid unnecessary re-renders.

Code Reusability and Modularity: We assumed that designing code with a focus on reusability and modularity would improve maintainability and facilitate future updates or extensions to the application.

Error Handling: We assumed the significance of robust error handling mechanisms to gracefully manage unexpected errors and provide informative feedback to users when issues occur.

These assumptions provide insights into the development philosophy and priorities guiding the project's implementation, contributing to a better understanding of its architecture and design decisions.

replace we with I
ChatGPT
Certainly, here's the revised section with "I" instead of "we":

Assumptions Made During Development
Efficient Data Structure Top-Down Approach: I assumed that employing efficient data structures and algorithms, with a top-down design approach, would optimize performance and scalability.

Limiting Data Fetch at a Time: I assumed that limiting the amount of data fetched at a time, through pagination or other techniques, would enhance the application's responsiveness and reduce server load.

Responsive UI: I assumed the importance of a responsive user interface across various devices and screen sizes to ensure a seamless user experience.

Efficient State Management Solution: I assumed the necessity of an efficient state management solution, such as Redux or Context API in React, to manage application state effectively and avoid unnecessary re-renders.

Code Reusability and Modularity: I assumed that designing code with a focus on reusability and modularity would improve maintainability and facilitate future updates or extensions to the application.

Error Handling: I assumed the significance of robust error handling mechanisms to gracefully manage unexpected errors and provide informative feedback to users when issues occur.

These assumptions provide insights into my development philosophy and priorities guiding the project's implementation, contributing to a better understanding of its architecture and design decisions.

it was for flutter
ChatGPT
Got it. Let's adjust the assumptions for a Flutter project:

Assumptions Made During Development

Efficient Data Structure Top-Down Approach: I assumed that employing efficient data structures and algorithms, with a top-down design approach, would optimize performance and scalability within the Flutter framework.

Limiting Data Fetch at a Time: I assumed that limiting the amount of data fetched at a time, perhaps through pagination or lazy loading, would enhance the responsiveness of the Flutter application and minimize network overhead.

Responsive UI: I assumed the importance of creating a responsive user interface adaptable to various screen sizes and orientations, following Flutter's guidelines for responsive design.

Efficient State Management Solution: I assumed the necessity of an efficient state management solution, such as Provider or Riverpod in Flutter, to manage application state effectively and optimize UI updates.

Code Reusability and Modularity: I assumed that structuring the codebase for reusability and modularity, utilizing features like widgets and packages, would improve maintainability and facilitate future enhancements or expansions of the Flutter application.

Error Handling: I assumed the significance of implementing robust error handling mechanisms, including try-catch blocks and error widgets, to gracefully manage unexpected errors and provide informative feedback to users during runtime.




Challenges Faced and Solutions

 Implementing pagination for Firebase data and I overcame this challenge by carefully structuring Firestore queries with pagination parameters such as startAfterDocument or startAfter.

Making Filter Selection Persistent only when Apply Button Pressed:
ensuring that filter selections remain persistent only after the user explicitly presses the apply button posed challenges. I use provider for that.  

Efficient Querying for Filtering and Sorting:Instead of fetching all brand documents and executing queries for each brand's shoes collection separately, 
consider using a single Firestore query that filters shoes based on all specified criteria.

Additional Features and Improvements

Pagination: Implemented pagination to limit the amount of data fetched at a time, reducing server load.

Caching Mechanism: Utilized a caching mechanism to store previously fetched data locally, reducing the need for repeated network requests.

Cached Network Image and shimmer effect: Implemented the use of cached network images and shimmer to display placeholders while actual images are being loaded,
providing an overview to the users before the actual data displays.
I have a plan to make it a complete feature rich app in the future.


