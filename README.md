# Shoe Commerce

A simple mobile application for selling shoes on both Android & iOS platforms.
<img width="1134" alt="Screenshot 2024-05-28 at 11 49 49 PM" src="https://github.com/nmustakim/shoe-commerce24/assets/98794936/b89bce3a-ec19-429b-9ef3-de564d7bea39">


## Project Setup Instructions

1. Clone the repository: `git clone https://github.com/nmustakim/projectname.git`
2. Ensure Flutter is installed: Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install) here.
3. Install dependencies: Run `flutter pub get`.
4. Run the project: Use `flutter run` to start the app on your connected device or simulator.

## Assumptions Made During Development

- **Efficient Data Structure Top-Down Approach**: Employed efficient data structures with a top-down design approach to optimize performance and scalability.
- **Limiting Data Fetch at a Time**: Limited the amount of data fetched at a time, perhaps through pagination.
- **Responsive UI**: Created a responsive user interface adaptable to various screen sizes and orientations using screen util.
- **Efficient State Management Solution**: Utilized an efficient state management solution, such as Provider or Riverpod, to manage states and update UI accordingly.
- **Code Re-usability and Modularity**: Structured the codebase for reusability and modularity.
- **Error Handling**: Implemented robust error handling mechanisms to manage unexpected errors and provide informative feedback to users.

## Challenges Faced and Solutions

- **Implementing Pagination for Firebase Data**: Carefully structured Firestore queries with pagination parameters such as `startAfterDocument` or `startAfter`.
- **Making Filter Selection Persistent only when Apply Button Pressed**: Ensured filter selections remain persistent only after the user explicitly presses the apply button using Provider.
- **Efficient Querying for Filtering and Sorting**: Utilized a single Firestore query that filters shoes based on all specified criteria to improve efficiency.

## Additional Features and Improvements

- **Pagination**: Implemented pagination to limit the amount of data fetched at a time, reducing server load.
- **Caching Mechanism**: Utilized a caching mechanism to store previously fetched data locally, reducing the need for repeated network requests.
- **Review by Rating**: Added the feature to see reviews by stars.
- **Cached Network Image and Shimmer Effect**: Implemented the use of cached network images and shimmer to display placeholders while actual images are being loaded, providing an overview to the users before the actual data displays. Plans to make it a complete feature-rich app in the future.

