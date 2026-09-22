class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6e93e3bda30616894fb84bc710a4bf382e1e316d3bea5ecf8c62c5db9c740c2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "7735f4cd063321baf75bc11ca88ad3c6f2f0a6cf446e8092a119741bbfb40514"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd6388fc3720b5a7f48226c87c6b2f727fad684ae4ed7cea1583b1c41499fe7d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ddca546cb03226abaa2ac7e4442c401123f94aab10d557066e63a83057639f6"
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
      bin.install "gg-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gg-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gg-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gg-mcp"
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
