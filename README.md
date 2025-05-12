# thoughtful

## How to Use

Run it from the command line using Node.js, passing the width, height, length, and mass as arguments:

```
node sort.js 10 10 10 15
```

This will output: STANDARD

Explanation
Volume Calculation: Computes the volume as width * height * length.

Bulky Check: A package is bulky if its volume is ≥ 1,000,000 cm³ or any dimension (width, height, length) is ≥ 150 cm.

Heavy Check: A package is heavy if its mass is ≥ 20 kg.

Sorting Logic:
If both bulky and heavy, return "REJECTED".

If either bulky or heavy, return "SPECIAL".

Otherwise, return "STANDARD".

Unexpected parameters return "ERROR".

Command-Line Support: The script checks if it's being run directly (require.main === module), parses command-line arguments, and outputs the result. It expects four numeric arguments and provides an error message if the input is invalid.
