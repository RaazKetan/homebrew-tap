class Creo < Formula
  desc "Menu bar app to find and resume Claude Code and Codex sessions"
  homepage "https://github.com/RaazKetan/creo"
  url "https://github.com/RaazKetan/creo/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "a6ae2a2c733f06c0a9893df82477f2d7e7a4c6b8805a0e134b3a8af933884ba5"
  license "MIT"
  head "https://github.com/RaazKetan/creo.git", branch: "main"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "Creo.app"
  end

  def caveats
    <<~EOS
      Open Creo once to add it to your login items:
        open #{opt_prefix}/Creo.app
    EOS
  end

  test do
    assert_match "sessions", shell_output("#{prefix}/Creo.app/Contents/MacOS/creo --list")
  end
end
