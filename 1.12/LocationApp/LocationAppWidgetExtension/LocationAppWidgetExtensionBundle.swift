//
//  LocationAppWidgetExtensionBundle.swift
//  LocationAppWidgetExtension
//
//  Created by ali cihan on 7.10.2025.
//

import WidgetKit
import SwiftUI

@main
struct LocationAppWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        LocationAppWidgetExtension()
        LocationAppWidgetExtensionControl()
    }
}
