cask "claude-sessions" do
  version "1.10.3"
  sha256 "83820668051e0f1aff0006e5c89584215ba1ba761d92300a620511c256937c71"

  url "https://github.com/RaazKetan/claude-session-manager/releases/download/v#{version}/ClaudeSessions.app.zip"
  name "Claude Sessions"
  desc "Menu bar app to browse and resume Claude Code and Codex sessions"
  homepage "https://github.com/RaazKetan/claude-session-manager"

  depends_on macos: :ventura

  app "ClaudeSessions.app"

  # Ad-hoc signed, so macOS quarantines the download and Gatekeeper refuses to
  # open it. Strip the flag here rather than making every user run xattr.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClaudeSessions.app"],
                   sudo: false

    # Builds before 1.10.3 do not yet watch their bundle for replacement. Restart a running
    # copy during this upgrade; 1.10.3 and later can hand off to future versions themselves.
    system_command "/bin/sh",
                   args: [
                     "-c",
                     "if /usr/bin/pgrep -x ClaudeSessions >/dev/null; then " \
                     '/usr/bin/pkill -x ClaudeSessions; /usr/bin/open "$0"; fi',
                     "#{appdir}/ClaudeSessions.app",
                   ],
                   sudo: false
  end

  zap trash: "~/Library/Application Support/ClaudeSessions"

  caveats <<~EOS
    This build is ad-hoc signed rather than notarized. The install strips the
    quarantine flag for you; if macOS still refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/ClaudeSessions.app
  EOS
end
