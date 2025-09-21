import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Création de l'élément dans la barre de menu
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            if let icon = NSImage(named: "Deepcool") {
                icon.isTemplate = false // Met à true si tu veux une icône monochrome
                button.image = icon
            } else {
                print("❌ L'icône 'Deepcool' n’a pas été trouvée.")
            }

            button.toolTip = "AK620 Pro Controller"
        }

        // Menu contextuel
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Ouvrir", action: #selector(openMainWindow), keyEquivalent: "o"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quitter", action: #selector(quitApp), keyEquivalent: "q"))
        statusItem.menu = menu

        // Mise à jour toutes les 5 secondes
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.updateStatusItem()
        }

        // Mise à jour immédiate
        updateStatusItem()
    }

    func updateStatusItem() {
        DispatchQueue.main.async {
            if let button = self.statusItem.button {
                let temp = self.getTemperature()
                let freq = self.getFrequency()
                button.title = String(format: " %d°C %.2fGHz", temp, freq)
            }
        }
    }

    func getTemperature() -> Int {
        // TODO : remplacer par ta méthode réelle
        return Int.random(in: 35...70)
    }

    func getFrequency() -> Double {
        // TODO : remplacer par ta méthode réelle
        return Double.random(in: 1.5...4.2)
    }

    @objc func openMainWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "AK620 Pro Controller"
        window.contentView = NSHostingView(rootView: ContentView())
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

