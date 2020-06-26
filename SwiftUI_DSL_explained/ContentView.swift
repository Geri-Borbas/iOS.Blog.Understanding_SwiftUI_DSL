//
//  ContentView.swift
//  SwiftUI_DSL
//
//  Created by Geri Borbás on 2020. 06. 26..
//

import SwiftUI


let hello = "Hello"
let world = "world!"

// Nothing to do with Bindings, or View updates.
// This is all compile time stuff.
// The point is to


/// Standard SwiftUI.
struct ContentView_standard: View
{
        
    
    var body: some View
    {
        HStack
        {
            Text(hello)
            Text(world).bold().padding(-5)
        }
    }
}


/// Removing omitted return keyword (https://github.com/apple/swift-evolution/blob/master/proposals/0255-omit-return.md).
struct ContentView_without_Omitted_return: View
{
        
    
    var body: some View
    {
        return HStack
        {
            Text(hello)
            Text(world)
        }
    }
}


/// Removing opaque return types (https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md).
struct ContentView_without_Opaque_return_types: View
{
        
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        return HStack
        {
            Text(hello)
            Text(world)
        }
    }
}


/// Explicit function builders in stack (https://github.com/apple/swift-evolution/pull/1046)
struct ContentView_explicit_Function_Builders: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        return HStack(content:
        {
            return ViewBuilder.buildBlock(
                Text(hello), Text(world) // Simple function argument list
            )
        })
    }
}


/// Explicit and typed function builders in stack (https://github.com/apple/swift-evolution/pull/1046)
struct ContentView_explicit_and_typed_Function_Builders: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        // It is a closure returning the desired view type.
        let closure: () -> TupleView<(Text, Text)> =
        {
            return ViewBuilder.buildBlock(
                Text(hello), Text(world)
            )
        }
        
        return HStack(content: closure)
    }
}


/// Without function builders and typed (https://github.com/apple/swift-evolution/pull/1046)
struct ContentView_without_Function_Builders_and_typed: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        let closure: () -> TupleView<(Text, Text)> =
        {
            return TupleView(
                (Text(hello), Text(world)) // A Tuple of views indeed
            )
        }
        
        return HStack(content: closure)
    }
}


struct ContentView_typed: View
{
    
    
    var body: HStack<TupleView<(Text, Text)>>
    {
        // Views.
        let text_1: Text = Text(hello)
        let text_2: Text = Text(world)
        
        // Tuple and tuple view.
        let tuple: (Text, Text) = (text_1, text_2)
        let tupleView: TupleView<(Text, Text)> = TupleView(tuple)
        
        // Horizontal stack and its content.
        let closure: () -> TupleView<(Text, Text)> = { return tupleView }
        let horizontalStack: HStack<TupleView<(Text, Text)>> = HStack(content: closure)
        
        return horizontalStack
    }
}


struct ContentView_with_modifiers_typed: View
{
    
    
    var body: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>>
    {
        let text_1: Text = Text(hello)
        let text_2: Text = Text(world)
        
        let modifiedText_2: ModifiedContent<Text, _PaddingLayout> =
            text_2.padding(-5) as! ModifiedContent<Text, _PaddingLayout>
        
        let tupleViewViewBuilder: TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)> = ViewBuilder.buildBlock(
            Text(hello),
            modifiedText_2
        )
        
        let hStack: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>> =
            HStack(content: { return tupleViewViewBuilder })
        
        return hStack
    }
}



struct ContentView_Previews: PreviewProvider
{
    
    
    static var previews: some View
    { return ContentView_with_modifiers_typed() }
}
