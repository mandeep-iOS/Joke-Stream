# Joke-Stream

Joke-Stream is a mobile application that fetches and displays jokes from an external API.

## Tech Stack

- iOS 13+
- Swift
- UIKit

## Project Overview

Joke-Stream fetches jokes from an API and displays them in a list. It's a fun app that provides a daily dose of humor.

## Installation

1. Clone the repository.
2. Open the Xcode project.
3. Run the app on a simulator or device.

## Usage

- Launch the app.
- Enjoy the latest jokes displayed in the list.

## Features

- Fetches jokes from an external API.
- Displays jokes in a scrollable list.
- Dynamically adjusts label positioning and font size based on content length.

## Code Structure

The code is organized following the Model-View-Presenter (MVP) architecture. Key components include:
- `JokeModel`: Manages joke data and fetches jokes from the API.
- `JokePresenter`: Orchestrates data updates and handles error presentation.
- `JokeViewController`: Displays jokes in a UITableView.
- `JokeTVCell`: Custom table view cell for displaying jokes.

## Contributing

We welcome contributions! Please follow our [contribution guidelines](CONTRIBUTING.md).

## License

This project is not licensed under the MIT License.

## Contact

For questions or feedback, please email us at mdeep14293@gmail.com.
