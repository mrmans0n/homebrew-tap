class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.3/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "f4a2e8d5e245dc6bf283a365e63e5e623f651c7c7b4e5ab9e916907b5e4ee38b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.3/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "477185ea7726bc26b3010d2763e08a02a5b0bffca373730e2f03d9273c9a79cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.3/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8030802b0f7411c0f5b9b7712d10d5e7aa1b6920194a8c58fe03d76665ca6ad7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.3/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b036f875e599e441c0b3815662bc61e35016649450433bf1dfb7f3054e7d54d9"
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
