class GgStack < Formula
  desc "Stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.4.2/gg-stack-aarch64-apple-darwin.tar.xz"
      sha256 "521160636659f7b6b66c0de3ebdf7989606d38984daf2acf66059927a73aca61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.4.2/gg-stack-x86_64-apple-darwin.tar.xz"
      sha256 "f1633fdbfd04fa5c33115b859d86b122d6925d3c099ef41e659a2e41975d145b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.4.2/gg-stack-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "032b3e46a790376da5461c45cd0f7e6483916ba1223fa14f0d388368b5003caa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.4.2/gg-stack-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "31fa0bf6a354f1c83d4d1e83f157b2c531fa5a1eb6affea2a1f61154a0d06efa"
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
    bin.install "gg" if OS.mac? && Hardware::CPU.arm?
    bin.install "gg" if OS.mac? && Hardware::CPU.intel?
    bin.install "gg" if OS.linux? && Hardware::CPU.arm?
    bin.install "gg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
