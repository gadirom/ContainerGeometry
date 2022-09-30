# ContainerGeometry

This may be helpful for you if there is a need to get geometry information for multiple SwiftUI views, e.g. if you want to track views in a grid or in other containers.

## Usage

If you have a container that contains multiple views, you apply `container` modifier on this container. Like this:

```
VStack{
    ...
}.container()
```
This will make `ContainerGeometry` Environment Object available in the view subhierarchy, where you may get it like this:
```
@EnvironmentObject var geometryData: ContainerGeometry
```
But for the geometry to be readable you set it on the view itself:
```
SomeViewInsideYourContainer()
    .subviewGeometry(id: someHashableID)
```
Then you can read the geometry information of this view from the Environment Object like this:
```
let frameRect = geometryData[someHashableID]
```
Or get the geometry of the container:
```
let containerFrameRect = geometryData.containerFrame
```
Also, you may get all the IDs of the views that contain specific point like this:
```
let idsOfTheViewsContainingYourCGPoint = geometryData.frames(containing: yourCGPoint)
```
You may also set a callback for catching all the geometry changes:
```
geometryData.onGeometryUpdate = { geometryData in
    //use updated geometryData
}
```
Feel free to contact me with any questions or suggestions!


