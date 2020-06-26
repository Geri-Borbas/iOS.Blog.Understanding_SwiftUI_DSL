# SwiftUI DSL explained
### Recreating a SwiftUI hierarchy in vanilla Swift


Complementary repository for article series [SwiftUI DSL explained]. The following snippets produce identical results (take a look at [`ContentView.swift`] for more).

```Swift
struct ContentView: View
{
        
    
    var body: some View
    {
        HStack
        {
            Text("Hello")
            Text("world!").bold().padding(-5)
        }
    }
}
```

```Swift
struct ContentView: View
{
    
    
    var body: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>>
    {
        // Text (with modifiers).
        let helloText: Text = Text("Hello")
        let worldText: Text = Text("world!")
        let boldWorldText: Text = worldText.bold()
        let modifiedBoldWorldText: ModifiedContent<Text, _PaddingLayout> =
            boldWorldText.padding(-5) as! ModifiedContent<Text, _PaddingLayout>
        
        // Tuple and tuple view.
        let tuple: (Text, ModifiedContent<Text, _PaddingLayout>) = (helloText, modifiedBoldWorldText)
        let tupleView: TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)> = TupleView(tuple)
                
        // Horizontal stack and its content closure.
        let closure: () -> TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)> = { return tupleView }
        let horizontalStack: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>> = HStack(content: closure)
        
        return horizontalStack
    }
}
```

#### License
> Licensed under the [Open Source MIT license].


[SwiftUI DSL explained]: http://blog.eppz.eu/swiftui-dsl-explained-tupleview
[`ContentView.swift`]: SwiftUI_DSL_explained/ContentView.swift
[Open Source MIT license]: http://en.wikipedia.org/wiki/MIT_License




