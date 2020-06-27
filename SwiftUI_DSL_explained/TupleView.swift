//
//  ContentView.swift
//  SwiftUI_DSL
//
//  Created by Geri Borbás on 2020. 06. 26..
//

import SwiftUI


// Nothing to do with bindings, or view updates, this is all compile time stuff.
// Function builders are great indeed, but `TupleView` seems more central to the design.
// Function builders are actually a way to assemble tuples from function arguments.
// See `ModifiedContent_explicit_tuples` for more.


struct TupleView_standard: View
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


struct TupleView_without_Omitted_return: View
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


struct TupleView_without_Opaque_return_types: View
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


struct TupleView_explicit_Function_Builders: View
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


struct TupleView_explicit_and_typed_Function_Builders: View
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


struct TupleView_without_Function_Builders_and_typed: View
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


struct TupleView_dissected: View
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


struct TupleView_without_function_builders: View
{
    
    
    var body: some View
    {
        return HStack(content:
        {
            return TupleView((
                Text("Hello"),
                Text("world!")
            ))
        })
    }
}


struct ModifiedContent_standard: View
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


struct ModifiedContent_dissected: View
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


struct ModifiedContent_explicit_tuples: View
{
    
    
    var body: some View
    {
        return HStack(content:
        {
            return TupleView((
                Text("Hello"),
                Text("world!").bold().padding(-5)
            ))
        })
    }
}




struct ContentView_Previews: PreviewProvider
{
    
    
    static var previews: some View
    { return ModifiedContent_dissected() }
}
