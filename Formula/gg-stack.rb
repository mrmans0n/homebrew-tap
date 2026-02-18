class GgStack < Formula
  desc "Stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.3/gg-stack-aarch64-apple-darwin.tar.xz"
      sha256 "8bfc286004b27e6a34ba1c078e6f345b3aa36e425f3ec388ff133fd8788d45d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.3/gg-stack-x86_64-apple-darwin.tar.xz"
      sha256 "55ea8a7aedd09578a9172d4cd8b751992293613855411c4a286ff1765c5f4319"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.3/gg-stack-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37e3c3cf80eacd02d802a33a6ba2f4bafdb23c460147590904c908ffe23fd574"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.3/gg-stack-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea374ca1d07df7e1d3ef2ef866b5d8198882a10e74e77d8f62e517738293c95a"
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
