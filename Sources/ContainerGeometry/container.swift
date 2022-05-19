import SwiftUI

extension View{
    /// Supplies a ``ContainerGeometry`` Environment Object to a view subhierarchy.
    /// - Parameter coordSpace: An optional identifier of a specific coordinate space.
    ///
    /// Use this modifier on a container view for which you wish to get geometry information:
    /// ``` swift
    /// VStack{
    /// ...
    /// }.container()
    public func container(_ coordSpace: AnyHashable = UUID()) -> some View{
        self.modifier(Container(space: coordSpace))
    }
}

struct Container: ViewModifier {
    
    @StateObject var data: ContainerGeometry
    
    init(space: AnyHashable){
        _data = StateObject(wrappedValue: ContainerGeometry(coordSpace: space))
    }
    
    func updateFrames(newFrames:  [FramesPreferenceData]){
        data.frames = newFrames
        geometryUpdated()
    }
    func geometryUpdated(){
        if let proc = data.onGeometryUpdate{
            proc(data)
        }
    }
    func body(content: Content) -> some View {
        content
            .environmentObject(data)
            .onPreferenceChange(FramesPreferenceKey.self){ value in
                updateFrames(newFrames: value)
            }
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: FramePreferenceKey.self,
                                    value: geometry.frame(in: .named(data.space)))
                }
            )
            .onPreferenceChange(FramePreferenceKey.self){ value in
                //DispatchQueue.main.async {
                    data.containerFrame = value
                    geometryUpdated()
                //}
            }
            .coordinateSpace(name: data.space)
    }
}
