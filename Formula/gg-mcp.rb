class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.6/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "9a8dec2ba1a8449c9074c73d21f0e652659eaa90049d56017058036525bff84f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.6/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "c752c3440643821804f612874210f8c9788486a64c2100ee445a4b08a4171651"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.6/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c7af8ebe9921152c777831630ecb644a8bb29ceee89f2cf29e5a7ab22032303a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.6/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "939df85a55748e7381c89d75e751be963c6f3980adec4f03e27f43c26f31750e"
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
