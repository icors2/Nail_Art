import SwiftUI

struct SettingsView: View {
    @AppStorage("prefersHaptics") private var prefersHaptics = true
    @AppStorage("autosaveIntervalSeconds") private var autosaveIntervalSeconds = 1.0

    var body: some View {
        Form {
            Section("Studio Preferences") {
                Toggle("Enable Haptics", isOn: $prefersHaptics)
                HStack {
                    Text("Autosave Interval")
                    Spacer()
                    Text("\(autosaveIntervalSeconds, specifier: "%.1f")s")
                        .foregroundStyle(.secondary)
                }
                Slider(value: $autosaveIntervalSeconds, in: 0.5...5, step: 0.5)
            }

            Section("About") {
                LabeledContent("Version", value: "0.1.0")
                LabeledContent("Build", value: "Phase 1 Shell")
            }
        }
        .navigationTitle("Settings")
    }
}
