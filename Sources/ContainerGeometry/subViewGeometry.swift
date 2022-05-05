import SwiftUI

extension View{
    /// Provides geometry information for a subview
    /// - Parameter id: A unique identifier for a subview.
    ///
    /// Use this modifier to provide geometry information of a given subview.
    /// This information will be avaiable in the form of ``ContainerGeometry``
    /// Environment Object for every view that resides in a container for which
    /// ``container`` modifier is set:
    /// ```swift
    /// VStack{
    ///     subview
    ///         .subViewGeometry(id: someHashableID)
    /// }.container()
    /// ```
    public func subViewGeometry(id: AnyHashable) -> some View{
        self.modifier(ContentGeometry(id: id))
    }
}

struct ContentGeometry: ViewModifier {
    
    @EnvironmentObject private var data: ContainerGeometry
    
    let id: AnyHashable
    
    init(id: AnyHashable){
        self.id = id
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: FramesPreferenceKey.self,
                                    value: [FramesPreferenceData(id: id, bounds: geometry.frame(in: .named(data.space)))])
                }
            )
    }
}
