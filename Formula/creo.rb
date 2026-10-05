class Creo < Formula
  desc "Menu bar app to find and resume Claude Code and Codex sessions"
  homepage "https://github.com/RaazKetan/creo"
  url "https://github.com/RaazKetan/creo/archive/refs/tags/v1.12.4.tar.gz"
  sha256 "52e45d968c2390e60d505f07330166b25fac3325bbcaf63a7e5b50b6eaf0c6e4"
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
