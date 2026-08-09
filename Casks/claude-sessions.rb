cask "claude-sessions" do
  version "1.4.0"
  sha256 "cb8a3b84cb3443a924c7ad20c238a8e4f2327cb6c98f91cc2088b0fe980269b2"

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
