class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.0/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "92aaca500d600e8a1786c7ee0d11663237258d87c096aa93f458886a0a2ce926"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.0/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "9d35417fc97fcd47a6561f7333a9624fbc025f6c663218101bd6c67b940f199b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.0/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c75e10cb08af28c29c96b3914d30a7b8b333150c687fa8ffc65e8d693f0a859b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.0/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "06b835603de0c1c60a312e021c8521081f98bad65729738fe8aca2ef3ed87b2e"
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
    bin.install "gg-mcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "gg-mcp" if OS.mac? && Hardware::CPU.intel?
    bin.install "gg-mcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "gg-mcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
