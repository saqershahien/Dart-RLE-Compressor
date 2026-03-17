import 'dart:io';

void main(List<String> args) {
  // 1. Check if we have exactly 2 arguments
  if (args.length != 2) {
    print("Usage: dart rle.dart [compress|decompress] <filename>");
    exit(-1);
  }

  String command = args[0];
  String fileName = args[1];

  // 2. Route to the correct function based on the first argument
  if (command == "compress") {
    print("Compressing $fileName...");
    compress(fileName);
    print("Done! Created $fileName.rle");
  } else if (command == "decompress") {
    print("Decompressing $fileName...");
    decompress(fileName);
  } else {
    print("Unknown command: $command. Use 'compress' or 'decompress'.");
    exit(-1);
  }
}

// Ensure your compress function uses writeAsBytesSync for efficiency
void compress(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    print("Error: File not found");
    return;
  }

  final bytes = file.readAsBytesSync();
  final out = <int>[];

  for (int i = 0; i < bytes.length; i++) {
    int count = 1;
    // Count consecutive identical bytes (up to 255 to fit in one byte)
    while (i + 1 < bytes.length && bytes[i] == bytes[i + 1] && count < 255) {
      count++;
      i++;
    }
    out.add(bytes[i]); // The byte value
    out.add(count); // The number of times it repeats
  }

  File('$filePath.rle').writeAsBytesSync(out);
}

void decompress(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) return;

  final compressed = file.readAsBytesSync();
  final original = <int>[];

  // Read in pairs: [Value, Count]
  for (int i = 0; i < compressed.length; i += 2) {
    int char = compressed[i];
    int count = compressed[i + 1];
    for (int j = 0; j < count; j++) {
      original.add(char);
    }
  }

  // Removes .rle extension for the output name
  String outPath = filePath.replaceAll('.rle', '');
  File('$outPath').writeAsBytesSync(original);
  print("Done! Created $outPath");
}
