cask "creo" do
  version "1.12.3"
  sha256 "28c070e45d74c46c78c25bb02130a12198d8be61024d36e49f8126d454c7d49e"

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
