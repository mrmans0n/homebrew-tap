class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3ea487aba30fed71caa2ccf7e0585745a207fdc681bdd5171fe7f6977049945f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6b68eea051457ff185d8c0437dc423f9bb1e099f3dcaffec680424f61f9f4b20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fb2da16630ef5daf24a9d852c321955d8ac9c5692ea57c4bc667b84d24bdfcc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47d2782e498232a17508bf34dcefa99f424b17908342de0d51f59c1a6e3c3392"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gg"
    end

    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    BINARY_ALIASES[:"#{cpu}-#{os}"].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gg --version")
  end
end
