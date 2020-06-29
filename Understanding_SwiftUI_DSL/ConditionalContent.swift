//
//  ConditionalContent.swift
//  SwiftUI_DSL_explained
//
//  Created by Geri Borbás on 2020. 06. 27..
//

import SwiftUI


struct ConditionalContent_If_standard: View
{

    
    var useBoldFont = true
    
    
    var body: some View
    {
        VStack
        {
            Text("Hello")
            
            if useBoldFont
            { Text("world!").bold() }
            else
            { Text("world!") }
        }
    }
}


/// More at https://developer.apple.com/documentation/swiftui/viewbuilder/buildeither(first:)
/// This also can help at https://github.com/Cosmo/OpenSwiftUI/blob/master/Sources/OpenSwiftUI/ViewBuilder.swift
struct ConditionalContent_If_article: View
{
    
    
    var useBoldFont = true
   
    
    var body: VStack<TupleView<(Text, _ConditionalContent<Text, Text>)>>
    {
        VStack
        {
            // Views.
            let helloText: Text = Text("Hello")
            let worldText: Text = Text("world!")
            let boldWorldText: Text = Text("world!").bold()
           
            // Create content for each branch.
            let trueContent: _ConditionalContent<Text, Text> =
                ViewBuilder.buildEither(first: boldWorldText)
                // Equivalent to _ConditionalContent<Text, Text>(storage: .trueContent(worldText))
           
            let falseContent: _ConditionalContent<Text, Text> =
                ViewBuilder.buildEither(second: worldText)
                // Equivalent to _ConditionalContent<Text, Text>(storage: .falseContent(boldWorldText))
           
            // Pick either conditional content at runtime (with a type designating both).
            let boldWorldTextOrWorldText: _ConditionalContent<Text, Text> =
                useBoldFont ? trueContent : falseContent
           
            // Return tuple.
            return TupleView((helloText, boldWorldTextOrWorldText))
       }
   }
}


struct ConditionalContent_Switch_standard: View
{
    
    
    var alignment: TextAlignment = .leading
    
    
    var body: some View
    {
        Group
        {
            switch alignment
            {
                case .leading:
                    Text("Alignment is set to leading.")
                case .center:
                    Text("Alignment is set to center.")
                case .trailing:
                    Text("Alignment is set to trailing.")
            }
        }
    }
}


/// SwiftUI (with modifiers and branching) dissected.
struct ConditionalContent_Switch_article: View
{

    
    enum `Type` { case text, image, color, divider, spacer }
    var type: `Type` = .image
    
    
    var body: some View
    {
        let switchGroup: Group<_ConditionalContent<_ConditionalContent<_ConditionalContent<Text, Image>, _ConditionalContent<Color, Divider>>, Spacer>> =
            Group
            {
                switch type
                {
                    case .text:
                        Text("Text")
                    case .image:
                        Image(systemName: "photo")
                    case .color:
                        Color.red
                    case .divider:
                        Divider()
                    case .spacer:
                        Spacer()
                }
            }
        
        let ifElseGroup: Group<_ConditionalContent<_ConditionalContent<_ConditionalContent<Text, Image>, _ConditionalContent<Color, Divider>>, Spacer>> =
            Group
            {
                if type == .text
                { Text("Text") }
                else if type == .image
                { Image(systemName: "photo") }
                else if type == .color
                { Color.red }
                else if type == .divider
                { Divider() }
                else // if type == .spacer
                { Spacer() }
            }
        
        let textOrImage: _ConditionalContent<Text, Image> =
            type == .text ? ViewBuilder.buildEither(first: Text("Text")) : ViewBuilder.buildEither(second: Image(systemName: "photo"))
        
        let colorOrDivider: _ConditionalContent<Color, Divider> =
            type == .color ? ViewBuilder.buildEither(first: Color.red) : ViewBuilder.buildEither(second: Divider())
                
        let textOrImageOrColorOrDivider: _ConditionalContent<_ConditionalContent<Text, Image>, _ConditionalContent<Color, Divider>> =
            type == .text || type == .image ? ViewBuilder.buildEither(first: textOrImage) : ViewBuilder.buildEither(second: colorOrDivider)
        
        let textOrImageOrColorOrDividerOrSpacer: _ConditionalContent<_ConditionalContent<_ConditionalContent<Text, Image>, _ConditionalContent<Color, Divider>>, Spacer> =
            type == .text || type == .image || type == .color || type == .divider ? ViewBuilder.buildEither(first: textOrImageOrColorOrDivider) : ViewBuilder.buildEither(second: Spacer())
        
        print(Mirror(reflecting: switchGroup))
        print(Mirror(reflecting: ifElseGroup))
        print(Mirror(reflecting: textOrImageOrColorOrDividerOrSpacer))
        
        return VStack
        {
            Text("Heading")
            textOrImageOrColorOrDividerOrSpacer
        }
    }
}


// MARK: - Previews

#if DEBUG
struct ConditionalContent_Previews: PreviewProvider
{
    static var previews: some View
    {
        Group
        {
            ConditionalContent_If_standard()
                .previewDisplayName("ConditionalContent_If_standard")
            
            ConditionalContent_If_article()
                .previewDisplayName("ConditionalContent_If_article")
            
            ConditionalContent_Switch_standard()
                .previewDisplayName("ConditionalContent_Switch_standard")
            
            ConditionalContent_Switch_article()
                .previewDisplayName("ConditionalContent_Switch_article")
        }
    }
}
#endif
