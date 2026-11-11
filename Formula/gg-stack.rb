class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.6/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b56840a45c6844e06c12cc49dc7ac7a679377a301eaa78a5d9722f9b44f30fe6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.6/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c2bb8926878d20a5f391f3e073d6cc3ff144ec2962413e0bdaeebfc93ce4fe61"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.6/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ea6a92238ac70f7b5d2ed2520078abf17ec02404a6b3de72cfc8b427643f1d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.6/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a38dcc3b131b9f2d20a6806edd7a829edb6d0c6026b27305529f2128143be30"
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
end
