//
//  ContentView.swift
//  SwiftUI_DSL
//
//  Created by Geri Borbás on 2020. 06. 26..
//

import SwiftUI


// Nothing to do with bindings, or view updates, this is all compile time stuff.
// Function builders are great indeed, but `TupleView` seems more central to the design.


/// Standard SwiftUI.
struct ContentView_standard: View
{
        
    
    var body: some View
    {
        HStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


/// Removing omitted return keyword.
/// More at https://github.com/apple/swift-evolution/blob/master/proposals/0255-omit-return.md.
struct ContentView_without_Omitted_return: View
{
        
    
    var body: some View
    {
        return HStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


/// Removing opaque return types.
/// More at https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md.
struct ContentView_without_Opaque_return_types: View
{
        
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        return HStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


/// Explicit function builders in stack.
/// More at https://github.com/apple/swift-evolution/pull/1046.
struct ContentView_explicit_Function_Builders: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        return HStack(content:
        {
            return ViewBuilder.buildBlock(
                Text("Hello"), Text("world!") // Simple function argument list
            )
        })
    }
}


/// Explicit and typed function builders in stack.
/// More at https://github.com/apple/swift-evolution/pull/1046.
struct ContentView_explicit_and_typed_Function_Builders: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        // It is a closure returning the desired view type.
        let closure: () -> TupleView<(Text, Text)> =
        {
            return ViewBuilder.buildBlock(
                Text("Hello"), Text("world!")
            )
        }
        
        return HStack(content: closure)
    }
}


/// Without function builders and typed.
/// More at https://github.com/apple/swift-evolution/pull/1046.
struct ContentView_without_Function_Builders_and_typed: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        let closure: () -> TupleView<(Text, Text)> =
        {
            return TupleView(
                (Text("Hello"), Text("world!")) // A Tuple of views indeed
            )
        }
        
        return HStack(content: closure)
    }
}


/// Everything dissected.
struct ContentView_dissected: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        // Views.
        let helloText: Text = Text("Hello")
        let worldText: Text = Text("world!")
        
        // Tuple and tuple view.
        let tuple: (Text, Text) = (helloText, worldText)
        let tupleView: TupleView<(Text, Text)> = TupleView(tuple)
        
        // Horizontal stack and its content closure.
        let closure: () -> TupleView<(Text, Text)> = { return tupleView }
        let horizontalStack: HStack<TupleView<(Text, Text)>> = HStack(content: closure)
        
        return horizontalStack
    }
}


/// Standard SwiftUI (with modifiers).
struct ContentView_with_modifiers_standard: View
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



/// SwiftUI (with modifiers) dissected.
struct ContentView_with_modifiers_dissected: View
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


/// Standard SwiftUI (with modifiers and branching).
struct ContentView_with_modifiers_and_branching_standard: View
{

    
    let useBoldFont = true
    
    
    var body: some View
    {
        return HStack
        {
            Text("Hello")
            switch useBoldFont
            {
                case false:
                    Text("world!")
                case true:
                    Text("world!").bold().padding(-5)
            }
        }
    }
}


/// SwiftUI (with modifiers and branching) dissected.
struct ContentView_with_modifiers_and_branching_dissected: View
{

    
    @State var useBoldFont = true
    
    
    var body: some View
    {
        // Text (with modifiers).
        let helloText: Text = Text("Hello")
        let worldText: Text = Text("world!")
        let modifiedWorldText: ModifiedContent<Text, _PaddingLayout> =
            worldText.padding(-5) as! ModifiedContent<Text, _PaddingLayout>
        let boldWorldText: Text = worldText.bold()
        let modifiedBoldWorldText: ModifiedContent<Text, _PaddingLayout> =
            boldWorldText.padding(-5) as! ModifiedContent<Text, _PaddingLayout>
            
        // Conditional content.
        let groupedConditionalContent: Group<_ConditionalContent<ModifiedContent<Text, _PaddingLayout>, ModifiedContent<Text, _PaddingLayout>>> =
            Group
            {
                switch useBoldFont
                {
                    case false:
                        modifiedWorldText
                    case true:
                        modifiedBoldWorldText
                }
            }
        
        // Let tuple creation and function builders standard this time.
        return HStack
        {
            helloText
            groupedConditionalContent
        }
            .onTapGesture
            { useBoldFont.toggle() }
    }
}




struct ContentView_Previews: PreviewProvider
{
    
    
    static var previews: some View
    { return ContentView_with_modifiers_and_branching_dissected() }
}
