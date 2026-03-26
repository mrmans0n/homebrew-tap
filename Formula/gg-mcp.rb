class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.7.2/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "12cef87034fd4b571484bd046729c9cf4b929826c97687c9e62749a855fd90a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.7.2/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "341271b4b62308204f77671148b1fb56f355d6913a6170c57570a1bda33b5eeb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.7.2/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "89af57dac3411b7af94dccbe62fa362fe24194c96eff215e6fca308c7479641d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.7.2/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "564a557db4c0aa69dd084c924bda73b42e01f5e06a4c402e94f66743048212da"
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
