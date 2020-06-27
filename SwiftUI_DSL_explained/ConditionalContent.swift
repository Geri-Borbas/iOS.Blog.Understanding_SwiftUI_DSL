//
//  ConditionalContent.swift
//  SwiftUI_DSL_explained
//
//  Created by Geri Borbás on 2020. 06. 27..
//

import Foundation
import SwiftUI


/// Standard SwiftUI (with modifiers and branching).
struct ConditionalContent_If_standard: View
{

    
    @State var useBoldFont = true
    
    
    var body: some View
    {
        HStack
        {
            Text("Hello")
            
            if useBoldFont
            { Text("world!").padding(-5) }
            else
            { Text("world!").bold().padding(-5) }
        }
            .onTapGesture
            { self.useBoldFont.toggle() }
    }
}


/// Standard SwiftUI (with modifiers and branching).
struct ConditionalContent_If_inspect: View
{

    
    @State var useBoldFont = true
    
    
    typealias ModifiedTextType = ModifiedContent<Text, _PaddingLayout>
    
    
    var body: some View
    {
        HStack
        {
            () -> TupleView<(Text, _ConditionalContent<ModifiedTextType, ModifiedTextType>)> in
            
            // Views.
            let text: Text = Text("Hello")
            let modifiedText: ModifiedTextType = Text("world!").padding(-5) as! ModifiedTextType
            let modifiedBoldText: ModifiedTextType = Text("world!").bold().padding(-5) as! ModifiedTextType
            
            // Conditional content.
            let conditionalContent: _ConditionalContent<ModifiedTextType, ModifiedTextType> =
                ViewBuilder.buildBlock(
                    
                    useBoldFont ?
                        
                        // buildEither(first:)
                        // Provides support for “if” statements in multi-statement
                        // closures, producing ConditionalContent for the “then” branch.
                        ViewBuilder.buildEither(first: modifiedText) :
                        
                        // buildEither(second:)
                        // Provides support for “if-else” statements in multi-statement
                        // closures, producing ConditionalContent for the “else” branch.
                        ViewBuilder.buildEither(second: modifiedBoldText)
                   )
            
            // Tuple.
            let tuple: (Text, _ConditionalContent<ModifiedTextType, ModifiedTextType>) =
                (text, conditionalContent)
            let tupleView: TupleView<(Text, _ConditionalContent<ModifiedTextType, ModifiedTextType>)> =
                TupleView(tuple)
            
            return tupleView
        }
            .onTapGesture
            { self.useBoldFont.toggle() }
    }
}


// https://developer.apple.com/documentation/swiftui/viewbuilder/buildeither(first:)
// https://forums.swift.org/t/swiftui-viewbuilder-can-be-applied-to-body/31120/2
// https://github.com/Cosmo/OpenSwiftUI/blob/master/Sources/OpenSwiftUI/ViewBuilder.swift

//if condition
//{ return _ConditionalContent<Text, Rectangle>(first: Text("Text")) }
//else
//{ return _ConditionalContent<Text, Rectangle>(second: Rectangle()) }


/// Standard SwiftUI (with modifiers and branching).
struct ConditionalContent_Switch_standard: View
{
    
    
    @State var useBoldFont = true
    
    
    var body: some View
    {
        HStack
        {
            Text("Hello")
            switch useBoldFont
            {
                case false:
                    Text("world!").padding(-5)
                case true:
                    Text("world!").bold().padding(-5)
            }
        }
            .onTapGesture
            { self.useBoldFont.toggle() }
    }
}


/// SwiftUI (with modifiers and branching) dissected.
struct ConditionalContent_Switch_dissected: View
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


struct ConditionalContent_Previews: PreviewProvider
{
    
    
    static var previews: some View
    { return ConditionalContent_If_inspect() }
}
