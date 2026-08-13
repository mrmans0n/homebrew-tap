class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.1/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "62598b0f8f04125e29410b89fe757d4b59ef5f7ae3aaaaff29938cad22ddba05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.1/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "e785b4923407788a70cca64be3a801c4249360e606e41013c1a01e74b67474dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.1/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "24dd94da2533cbca4c04957c72e4115ffa51f763fa3d8e47c5f4ca0c8241c460"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.1/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9aa41e0e1b00eb0da020054e298378e3525339adc45ac64142882f7ddb7790ac"
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
