import SwiftUI

struct FramesPreferenceData: Equatable {
    let id: AnyHashable
    let bounds: CGRect
}

struct FramesPreferenceKey: PreferenceKey {
    typealias Value = [FramesPreferenceData]
    
    static var defaultValue: [FramesPreferenceData] = []
    
    static func reduce(value: inout [FramesPreferenceData], nextValue: () -> [FramesPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
