class GgStack < Formula
  desc "stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.2.1/gg-stack-aarch64-apple-darwin.tar.xz"
      sha256 "bd4f3b922f65eb225fb76d69c44827ac927d07fbdb12742ff6b0998ec2aa8546"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.2.1/gg-stack-x86_64-apple-darwin.tar.xz"
      sha256 "659f3263b75caa43d2eef20bed883797779847e7a6674a0cb3a49f88cb054c2b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.2.1/gg-stack-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4d61f23cc3232d7ba93dd5179322822e2f4a578f51f33f2b4ff3a082fb4aa0d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.2.1/gg-stack-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "969bf20706468e325d4d41490b6abb3405d841a96dd3c4156e4b3b0a8bb49774"
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
