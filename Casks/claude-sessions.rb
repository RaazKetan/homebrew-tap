cask "claude-sessions" do
  version "1.8.2"
  sha256 "1c8e2e629fc4c8f8e8b2abb895807c6710ff423214aab9d833d20dd6e5df104e"

  url "https://github.com/RaazKetan/claude-session-manager/releases/download/v#{version}/ClaudeSessions.app.zip"
  name "Claude Sessions"
  desc "macOS menu bar app to browse and resume your Claude Code sessions"
  homepage "https://github.com/RaazKetan/claude-session-manager"

  depends_on macos: :ventura

  app "ClaudeSessions.app"

  # Ad-hoc signed, so macOS quarantines the download and Gatekeeper refuses to
  # open it. Strip the flag here rather than making every user run xattr.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClaudeSessions.app"],
                   sudo: false
  end

  caveats <<~EOS
    This build is ad-hoc signed rather than notarized. The install strips the
    quarantine flag for you; if macOS still refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/ClaudeSessions.app
  EOS

  zap trash: [
    "~/Library/Application Support/ClaudeSessions",
  ]
end
