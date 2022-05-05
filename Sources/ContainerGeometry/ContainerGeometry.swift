import SwiftUI

/// Class that provides geometry information of a container and its subviews.
///
/// This object should not be created manually. Instead it is made available in the environment
/// of subviews of a container by using on it ``.container()`` modifier.
///
/// The subview's geometry is available via subscript that returns CGRect:
/// ```swift
/// let frameRect = containerObject[id]
/// ```
/// where `id` is a Hashable identifier
/// that was provided in ``.subviewGeometry(id:)`` modifier.
public final class ContainerGeometry: ObservableObject{
    /// The name of a coordinate space.
    public let space: AnyHashable
    /// The frame of container view.
    public  var containerFrame = CGRect()
    
    var frames: [FramesPreferenceData] = []
    
    /// A callback that is being triggered when geometry of subviews is changed.
    public var onGeometryUpdate: ((ContainerGeometry)->())?
    
    init(coordSpace: AnyHashable){
        space = coordSpace
    }
}

public extension ContainerGeometry{
    subscript(id: AnyHashable) -> CGRect?{
        frames.first(where: { $0.id == id })?.bounds
    }
    
    /// Method that returns all the identifiers of subviews that contain given location.
    func frames(containing location: CGPoint) -> [AnyHashable]{
        frames
            .filter{ $0.bounds.contains(location) }
            .map{ $0.id }
    }
}
