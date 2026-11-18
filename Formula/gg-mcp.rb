class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.9/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "b05bb5ec122de507819699d68c658b6bc85962cbefa972cd3e364d7c71d472f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.9/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "6ef5e7e721c3deb6aef5a2da4a66d03ff25003e21dd2324f9029f85ebaa9a647"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.9/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d1e2f9abb05a3eeb70a1c30ac230168cf963c7106074766e7cb067098ac6eb54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.9/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bc019985c34c3ee1e181dd0fb85b20c19291aa41531e544e951312a964da69ca"
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
