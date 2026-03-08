//
//  FolderPanelAccessoryView.swift
//  Simple Claude fits viewer
//

import SwiftUI

/// Mutable options captured by the Open Folder panel's accessory view.
/// Changes in the panel do NOT write back to AppSettings — callers read
/// `includeSubfolders` after `runModal()` returns and use it locally.
@Observable @MainActor
final class FolderPanelOptions {
    var includeSubfolders: Bool
    init(_ value: Bool) { includeSubfolders = value }
}

/// Accessory view embedded in the NSOpenPanel via NSHostingView.
struct FolderPanelAccessoryView: View {
    var options: FolderPanelOptions
    let excludedNames: [String]

    var body: some View {
        @Bindable var options = options
        VStack(alignment: .leading, spacing: 4) {
            Toggle("Include files from subfolders", isOn: $options.includeSubfolders)
            if !excludedNames.isEmpty {
                Text("Skipping: \(excludedNames.joined(separator: ", "))  —  edit in Settings → Images")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(width: 480, alignment: .leading)
    }
}
