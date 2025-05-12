function sort(width, height, length, mass) {
    if ([width, height, length, mass].some(arg => !arg || typeof(arg) !== 'number' || arg < 0)) {
        return "ERROR";
    }

    const volume = width * height * length;
    const isBulky = volume >= 1000000 || width >= 150 || height >= 150 || length >= 150;
    const isHeavy = mass >= 20;

    if (isBulky && isHeavy) {
        return "REJECTED";
    } else if (isBulky || isHeavy) {
        return "SPECIAL";
    } else {
        return "STANDARD";
    }
}

// For command-line execution
if (require.main === module) {
    const args = process.argv.slice(2).map(Number);
    if (args.length !== 4) {
        console.error("Please provide width, height, length, and mass as arguments");
        process.exit(1);
    }
    const [width, height, length, mass] = args;
    console.log(sort(width, height, length, mass));
}