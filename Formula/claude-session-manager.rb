class ClaudeSessionManager < Formula
  desc "macOS menu bar app to browse and resume your Claude Code sessions"
  homepage "https://github.com/RaazKetan/claude-session-manager"
  url "https://github.com/RaazKetan/claude-session-manager/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "d0522d9106c0cda89c37286f9794a5651b32a4f582ad8ebd54fe30c2f5f72b57"
  license "MIT"
  head "https://github.com/RaazKetan/claude-session-manager.git", branch: "main"

  # Ventura is the floor for MenuBarExtra and SMAppService.
  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "ClaudeSessions.app"
  end

  def caveats
    <<~EOS
      Launch it once and it adds itself to your login items:
        open #{opt_prefix}/ClaudeSessions.app

      On first launch it also installs the Spotify statusline plugin and points
      ~/.claude/settings.json at it. To skip that:
        mkdir -p ~/Library/Application\\ Support/ClaudeSessions
        touch ~/Library/Application\\ Support/ClaudeSessions/statusline-installed
    EOS
  end

  test do
    assert_match "sessions", shell_output("#{prefix}/ClaudeSessions.app/Contents/MacOS/ClaudeSessions --list")
  end
end
