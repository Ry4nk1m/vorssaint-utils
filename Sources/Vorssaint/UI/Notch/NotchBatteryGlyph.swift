import SwiftUI

/// A battery drawn to scale: the fill is exactly the charge level, like the
/// one in the macOS menu bar, instead of a fixed full-battery symbol.
struct NotchBatteryGlyph: View {
    let percent: Int?
    let isCharging: Bool
    let externalConnected: Bool
    var height: CGFloat = 11

    private var level: CGFloat { CGFloat(max(0, min(100, percent ?? 100))) / 100 }
    private var pluggedIn: Bool { isCharging || externalConnected }

    private var fillColor: Color {
        if pluggedIn { return .green }
        if let percent, percent <= 20 { return .red }
        return .white
    }

    var body: some View {
        let bodyWidth = height * 1.9
        let inset: CGFloat = 1.75
        let innerWidth = bodyWidth - inset * 2
        let innerHeight = height - inset * 2
        HStack(spacing: 1) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height * 0.3)
                    .stroke(Color.white.opacity(0.55), lineWidth: 1)
                RoundedRectangle(cornerRadius: height * 0.18)
                    .fill(fillColor)
                    .frame(width: level > 0 ? max(1.5, innerWidth * level) : 0, height: innerHeight)
                    .padding(.leading, inset)
                if pluggedIn {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: height * 0.6, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.55), radius: 0.6)
                        .frame(width: bodyWidth, height: height)
                }
            }
            .frame(width: bodyWidth, height: height)
            Capsule()
                .fill(Color.white.opacity(0.55))
                .frame(width: 1.5, height: height * 0.38)
        }
        .accessibilityHidden(true)
    }
}
