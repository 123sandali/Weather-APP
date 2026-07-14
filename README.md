# Weather Forecast App

A Flutter mobile application that provides real-time weather information using the user's current location or a searched city. The app integrates with WeatherAPI.com to display current conditions, hourly forecasts, and sunrise and sunset times.

## Features

- GPS-based current-location detection
- Current temperature and weather conditions
- Hourly weather forecasts
- City autocomplete search
- Sunrise and sunset information
- Weather condition icons
- Loading and basic error states
- Responsive Flutter user interface
- Colombo fallback when location access is unavailable

## Technologies

- Flutter
- Dart
- WeatherAPI.com REST API
- HTTP
- JSON
- Geolocator
- FutureBuilder
- Material UI
- Google Fonts
- Lottie
- Intl

## API Endpoints

The application uses the following WeatherAPI.com endpoints:

- `/v1/current.json` — current weather data
- `/v1/forecast.json` — hourly forecast data
- `/v1/search.json` — city autocomplete suggestions
- `/v1/astronomy.json` — sunrise and sunset data

## Project Structure

```text
lib/
├── main.dart
├── models/
│   ├── astroModel.dart
│   ├── autoComplete.dart
│   ├── condition.dart
│   ├── currentWeather.dart
│   └── hourlyWeather.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   └── placeview.dart
└── services/
    └── weather_services.dart
```

## Getting Started

### Prerequisites

Install the following:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android emulator or physical device
- A free WeatherAPI.com API key

### Installation

1. Clone the repository:

```bash
git clone https://github.com/123sandali/Weather-APP.git
cd Weather-APP
```

2. Install the dependencies:

```bash
flutter pub get
```

3. Add your WeatherAPI.com API key in:

```text
lib/services/weather_services.dart
```

Do not commit a real API key to a public repository. For improved security, store it using an environment configuration such as `--dart-define` or `flutter_dotenv`.

4. Run the application:

```bash
flutter run
```

## Permissions

The application requires:

- Internet access to retrieve weather data
- Location access to detect the user's current location

When location permission is unavailable, the application uses Colombo as the default location.

## How It Works

1. The splash screen requests location permission.
2. The app retrieves the user's latitude and longitude.
3. The weather service sends REST API requests to WeatherAPI.com.
4. JSON responses are converted into Dart model objects.
5. Flutter widgets display current weather and hourly forecast data.
6. Users can search for another city and view its weather and astronomy information.

## Current Limitations

- Displays hourly forecasts for one day
- Requires an internet connection
- Does not provide offline weather data
- Does not include air-quality information or weather alerts
- Uses basic error handling

## Security Note

Never expose a WeatherAPI key in source control. Revoke and regenerate any key that has already been committed publicly, then remove it from the source code and Git history.

## License

This project is intended for educational and portfolio purposes.