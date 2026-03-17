# Dart RLE Compressor

A simple command-line tool written in Dart that uses **Run-Length Encoding (RLE)** to compress and decompress files. It works by replacing consecutive identical bytes with a single byte value and a count (1–255).

## Features

- **Compress**: Reduces file size by encoding repeating byte sequences.
- **Decompress**: Restores `.rle` files back to their original state.
- **Efficient IO**: Uses synchronous byte streams for fast processing.

## Installation

1.  **Install Dart**: Ensure you have the [Dart SDK](https://dart.dev) installed.
2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/saqershahien/Dart-RLE-Compressor
    cd Dart-RLE-Compressor
    ```

## Usage

Run the tool using the `dart` command followed by the action and the filename:

```bash
dart rle.dart [compress|decompress] <filename>
