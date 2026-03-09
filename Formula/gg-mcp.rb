class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.4/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "39329fdef488cb5d96cc7a10b5320f2e2dfe035736e170fcada7992c8391c20c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.4/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "50500f933355af4d372363b951e48223ebd6e422815e2723447574d239d540d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.4/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2827c6d6d2feb755679bbf1b5489f65eb028559028071e6a3d4ca80abd0455ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.5.4/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "32111a6691b6e3d7400747dc702ab8488360b293baf59c5875cd18008395ebda"
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
