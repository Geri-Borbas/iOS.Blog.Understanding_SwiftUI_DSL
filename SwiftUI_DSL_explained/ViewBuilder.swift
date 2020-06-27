//
//  ViewBuilder.swift
//  SwiftUI_DSL_explained
//
//  Created by Geri Borbás on 2020. 06. 27..
//

import Foundation
import SwiftUI


/// Extend `ViewBuilder` to be able to build more than 10 view.
struct ViewBuilder_extension: View
{
    
    
    var when = true
    
    
    var body: some View
    {
        VStack
        {
            Text("1")
            Text("2")
            Text("3")
            Text("4")
            Text("5")
            Text("6")
            Text("7")
            Text("8")
            Text("9")
            Text("10")
            Text("11")
            Text("12")
            Text("13")
            Text("14")
            Text("15")
        }
    }
}



@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension ViewBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
        _ c5: C5,
        _ c6: C6,
        _ c7: C7,
        _ c8: C8,
        _ c9: C9,
        _ c10: C10,
        _ c11: C11,
        _ c12: C12,
        _ c13: C13,
        _ c14: C14) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14)>
    where
        C0 : View,
        C1 : View,
        C2 : View,
        C3 : View,
        C4 : View,
        C5 : View,
        C6 : View,
        C7 : View,
        C8 : View,
        C9 : View,
        C10 : View,
        C11 : View,
        C12 : View,
        C13 : View,
        C14 : View
    {
        let tuple = (c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14)
        let tupleView = TupleView(tuple)
        return tupleView
    }
}
