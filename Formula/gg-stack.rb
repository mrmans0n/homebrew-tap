class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.7/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3711d4724f507a51494bf97993e4bbb775d3f742aab448f092138b3dcf06cf75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.7/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a688f091aaddd9e904de27413fadd91975666cf1d0ba7d1daf2d13050cfe9009"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.7/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "839aa1d3597932dcfa4052060e8860fed02764368fa6602351522741496fc691"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.7/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "433aa0c50cfd548247b9227c026afdf14b4edf8da0a05adc3f6388c9834a11a1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

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

    install_binary_aliases!

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
