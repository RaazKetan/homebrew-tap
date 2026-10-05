class Creo < Formula
  desc "Menu bar app to find and resume Claude Code and Codex sessions"
  homepage "https://github.com/RaazKetan/creo"
  url "https://github.com/RaazKetan/creo/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "987d7abf47af19481d79f4834851b18dd4368f5486a33227d846de4970c53713"
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
