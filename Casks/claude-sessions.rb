cask "claude-sessions" do
  version "1.8.1"
  sha256 "9747415a7a7e8efc7102d8707cd2c3d4a3b2f1765d06b9fd1b2762965e628f67"

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
