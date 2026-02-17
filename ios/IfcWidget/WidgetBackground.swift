import SwiftUI
import WidgetKit

extension View {
    func widgetBackground(isTransparent: Bool) -> some View {
        modifier(WidgetBackgroundModifier(isTransparent: isTransparent))
    }
}

struct WidgetBackgroundModifier: ViewModifier {
    let isTransparent: Bool

    func body(content: Content) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            content
                .containerBackground(for: .widget) {
                    if isTransparent {
                        Color.clear
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                }
        } else {
            content
                .padding()
                .background(
                    Group {
                        if isTransparent {
                            Color.clear
                        } else {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.ultraThinMaterial)
                        }
                    }
                )
        }
    }
}
