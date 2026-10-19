class GgMcp < Formula
  desc "MCP server for git-gud (gg) stacked-diffs tool"
  homepage "https://mrmans0n.github.io/git-gud/"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.4/gg-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "ada28fa5523cfa43ae8ebeab60031ff9f5340b3b0eb085364289d6ad8d27a1a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.4/gg-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "4334bc5fd02ff3a7a58c98ad7ca1f0006718dc08322d494f58419ff7b2ecbc28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.4/gg-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ff3e45e4077b1fbd63025b4e25cede7e1fb53f4ee0f15d4c4f3aceed961a467"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.4/gg-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b34e91ba2e786a3b39bf8903cef9f7ce71a1cf3f2e581355ffcce7101b86fd77"
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

  test do
    request = <<~JSON
      {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"homebrew-test","version":"1.0"}}}
    JSON
    output = pipe_output(bin/"gg-mcp", request, 0)
    assert_match '"id":1', output
    assert_match '"capabilities":{"tools":{}}', output
  end
end
