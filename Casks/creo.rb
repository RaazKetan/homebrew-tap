cask "creo" do
  version "1.12.6"
  sha256 "cdb853f8298ade62299be8861be060d23728fc9899973d538d1c350c84c0bc35"

  url "https://github.com/RaazKetan/creo/releases/download/v#{version}/Creo.app.zip"
  name "Creo"
  desc "Menu bar app to find and resume Claude Code and Codex sessions"
  homepage "https://github.com/RaazKetan/creo"

  depends_on macos: :ventura

  app "Creo.app"

  # Homebrew's declarative install steps are sandboxed away from macOS RunningBoard, so they
  # cannot launch a GUI app. This compatibility block deliberately runs after the app is moved.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Creo.app"]
    system_command "/bin/sh",
                   args: ["-c", "sleep 1; /usr/bin/open \"$0\"", "#{appdir}/Creo.app"]
  end

  uninstall quit: "io.github.raazketan.creo"

  zap trash: [
    "~/Library/Application Support/ClaudeSessions",
    "~/Library/Application Support/Creo",
    "~/Library/LaunchAgents/dev.local.claudesessions.plist",
    "~/Library/LaunchAgents/io.github.raazketan.creo.plist",
  ]

  caveats <<~EOS
    Creo is ad-hoc signed rather than notarized. The cask clears its quarantine
    flag during installation. If macOS still refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/Creo.app
  EOS
end
