cask "claude-sessions" do
  version "1.0.0"
  sha256 "1070631eeaaff6cc7747cd9881ca77c8ad93f53b809e31f4c2f15cdc25e454cb"

  url "https://github.com/RaazKetan/claude-session-manager/releases/download/v#{version}/ClaudeSessions.app.zip"
  name "Claude Sessions"
  desc "macOS menu bar app to browse and resume your Claude Code sessions"
  homepage "https://github.com/RaazKetan/claude-session-manager"

  depends_on macos: ">= :ventura"

  app "ClaudeSessions.app"

  caveats <<~EOS
    This build is ad-hoc signed, not notarized. Install with --no-quarantine,
    or if macOS says the app is damaged:
      xattr -dr com.apple.quarantine /Applications/ClaudeSessions.app
  EOS

  zap trash: [
    "~/Library/Application Support/ClaudeSessions",
  ]
end
