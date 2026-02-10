class GgStack < Formula
  desc "A stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  version "0.1.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.1.15/gg-stack-aarch64-apple-darwin.tar.xz"
      sha256 "7590a71a43d819746628727bed90bdbb8f655eb7a8b8abbd33752604d8678599"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.1.15/gg-stack-x86_64-apple-darwin.tar.xz"
      sha256 "8d5480ece895272740874dc5840206fa3287952e7cf882cb2ee68b18ac2209ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.1.15/gg-stack-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ffa4fa5a73d7eb1f6c223feded78a47918749a8f9292c31f3ae72404ad595790"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.1.15/gg-stack-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed1a38a95838d8f380c74fe8ef6005a7d601a57ae02923ac19ace4871676d910"
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
