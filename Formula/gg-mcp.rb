class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "33724104423061d4ba48ef4ec1a664c69cb8d0220f25f05714f96405ce9ddf0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "4c6bcc9048374407453ec432afac2722bebcd5e924a047bce95c0b16619222b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "20b517d238dd18dc8b30bd5e8c1981ceadb7080be27bcab454acc90a192c8d62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.10/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eeec31b66402d9f3183c9f695896785b5c8707ea9cb0c1aab35fdbde5e70bea3"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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

    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    BINARY_ALIASES[:"#{cpu}-#{os}"].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    request = <<~JSON
      {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"homebrew-test","version":"1.0"}}}
    JSON
    output = pipe_output(bin/"gg-mcp", request, 0)
    assert_match '"id":1', output
    assert_match '"capabilities":{"tools":{}}', output
  end
end
