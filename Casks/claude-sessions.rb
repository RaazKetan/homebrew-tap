cask "claude-sessions" do
  version "1.1.0"
  sha256 "6ae3b2071b163eba5a38eaffff740322269e6aa9b01334a8b41726b9faf74c74"

  url "https://github.com/RaazKetan/claude-session-manager/releases/download/v#{version}/ClaudeSessions.app.zip"
  name "Claude Sessions"
  desc "macOS menu bar app to browse and resume your Claude Code sessions"
  homepage "https://github.com/RaazKetan/claude-session-manager"

  depends_on macos: :ventura

  app "ClaudeSessions.app"

  caveats <<~EOS
    This build is ad-hoc signed, not notarized, so macOS quarantines it.
    After installing, run:
      xattr -dr com.apple.quarantine /Applications/ClaudeSessions.app

    Or skip quarantine at install time:
      HOMEBREW_CASK_OPTS=--no-quarantine brew install --cask RaazKetan/tap/claude-sessions
  EOS

  zap trash: [
    "~/Library/Application Support/ClaudeSessions",
  ]
end
