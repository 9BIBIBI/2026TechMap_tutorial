import AppKit
import Foundation

guard CommandLine.arguments.count == 2 else {
    fputs("Usage: PlaceholderRenderer <output-directory> < manifest\n", stderr)
    exit(2)
}

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let manifestData = FileHandle.standardInput.readDataToEndOfFile()
guard let manifest = String(data: manifestData, encoding: .utf8) else {
    fputs("Manifest is not valid UTF-8.\n", stderr)
    exit(3)
}

let canvasSize = NSSize(width: 1600, height: 900)
let titleFont = NSFont.systemFont(ofSize: 38, weight: .bold)
let subtitleFont = NSFont.systemFont(ofSize: 25, weight: .regular)
let filenameFont = NSFont.monospacedSystemFont(ofSize: 22, weight: .regular)
let instructionFont = NSFont.systemFont(ofSize: 20, weight: .regular)

func drawText(_ text: String, at point: NSPoint, font: NSFont, color: NSColor) {
    text.draw(
        at: point,
        withAttributes: [
            .font: font,
            .foregroundColor: color,
        ]
    )
}

for line in manifest.split(whereSeparator: \.isNewline) {
    let fields = line.split(separator: "|", maxSplits: 2, omittingEmptySubsequences: false).map(String.init)
    guard fields.count == 3 else {
        fputs("Invalid manifest line: \(line)\n", stderr)
        exit(4)
    }

    let filename = fields[0]
    let title = fields[1]
    let subtitle = fields[2]

    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(canvasSize.width),
        pixelsHigh: Int(canvasSize.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        fputs("Unable to create bitmap context.\n", stderr)
        exit(5)
    }

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context

    let fullRect = NSRect(origin: .zero, size: canvasSize)
    let gradient = NSGradient(
        starting: NSColor(calibratedRed: 0.09, green: 0.21, blue: 0.36, alpha: 1),
        ending: NSColor(calibratedRed: 0.84, green: 0.92, blue: 0.96, alpha: 1)
    )!
    gradient.draw(in: fullRect, angle: -24)

    NSColor.white.withAlphaComponent(0.82).setFill()
    for point in [
        NSPoint(x: 180, y: 745),
        NSPoint(x: 330, y: 670),
        NSPoint(x: 1390, y: 720),
        NSPoint(x: 1260, y: 590),
    ] {
        NSBezierPath(ovalIn: NSRect(x: point.x, y: point.y, width: 12, height: 12)).fill()
    }

    let snowPath = NSBezierPath()
    snowPath.move(to: NSPoint(x: 0, y: 210))
    snowPath.curve(
        to: NSPoint(x: 560, y: 200),
        controlPoint1: NSPoint(x: 220, y: 320),
        controlPoint2: NSPoint(x: 380, y: 120)
    )
    snowPath.curve(
        to: NSPoint(x: 1080, y: 235),
        controlPoint1: NSPoint(x: 760, y: 290),
        controlPoint2: NSPoint(x: 900, y: 155)
    )
    snowPath.curve(
        to: NSPoint(x: 1600, y: 210),
        controlPoint1: NSPoint(x: 1280, y: 310),
        controlPoint2: NSPoint(x: 1430, y: 145)
    )
    snowPath.line(to: NSPoint(x: 1600, y: 0))
    snowPath.line(to: NSPoint(x: 0, y: 0))
    snowPath.close()
    NSColor(calibratedRed: 0.93, green: 0.97, blue: 0.99, alpha: 1).setFill()
    snowPath.fill()

    let cardRect = NSRect(x: 190, y: 235, width: 1220, height: 440)
    let shadow = NSShadow()
    shadow.shadowColor = NSColor(calibratedWhite: 0.05, alpha: 0.28)
    shadow.shadowOffset = NSSize(width: 0, height: -12)
    shadow.shadowBlurRadius = 20
    shadow.set()
    NSColor(calibratedWhite: 1, alpha: 0.94).setFill()
    NSBezierPath(roundedRect: cardRect, xRadius: 36, yRadius: 36).fill()

    NSShadow().set()
    NSColor(calibratedRed: 0.40, green: 0.66, blue: 0.82, alpha: 1).setFill()
    NSBezierPath(roundedRect: NSRect(x: 250, y: 395, width: 8, height: 220), xRadius: 4, yRadius: 4).fill()

    drawText(title, at: NSPoint(x: 310, y: 520), font: titleFont, color: NSColor(calibratedRed: 0.09, green: 0.27, blue: 0.42, alpha: 1))
    drawText(subtitle, at: NSPoint(x: 310, y: 455), font: subtitleFont, color: NSColor(calibratedRed: 0.25, green: 0.40, blue: 0.50, alpha: 1))
    drawText(filename, at: NSPoint(x: 310, y: 360), font: filenameFont, color: NSColor(calibratedRed: 0.42, green: 0.53, blue: 0.60, alpha: 1))
    drawText(
        "이 이미지를 같은 파일명의 실제 스크린샷으로 교체하세요.",
        at: NSPoint(x: 310, y: 305),
        font: instructionFont,
        color: NSColor(calibratedRed: 0.50, green: 0.59, blue: 0.65, alpha: 1)
    )

    context.flushGraphics()
    NSGraphicsContext.restoreGraphicsState()

    guard let pngData = bitmap.representation(using: .png, properties: [:]) else {
        fputs("Unable to encode PNG for \(filename).\n", stderr)
        exit(6)
    }

    try pngData.write(to: outputDirectory.appendingPathComponent(filename), options: .atomic)
}
