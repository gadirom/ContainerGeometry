import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue = CGRect()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
