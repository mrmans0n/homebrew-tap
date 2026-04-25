class Zjctl < Formula
  desc "Programmatic control bridge for Zellij panes and tabs"
  homepage "https://github.com/mrmans0n/zjctl"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/zjctl/releases/download/v0.1.0/zjctl-aarch64-apple-darwin.tar.xz"
      sha256 "5b34d9ea8a4041a3930029f72be57401690c19da45bbbf9efcb0ac997fe3c8b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/zjctl/releases/download/v0.1.0/zjctl-x86_64-apple-darwin.tar.xz"
      sha256 "6b3273820ab5a006262cde11149f20330562392506896a4b59c6d6181eb90180"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/zjctl/releases/download/v0.1.0/zjctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3818d375ef19c93f913570a17dba5e887977a45d536d4be595b21926b1fee73b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/zjctl/releases/download/v0.1.0/zjctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c556e4a4a2f3fc0a557fcf78662170dc036d6a9ecd566c794c7cc7051a96c95b"
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
    bin.install "zjctl" if OS.mac? && Hardware::CPU.arm?
    bin.install "zjctl" if OS.mac? && Hardware::CPU.intel?
    bin.install "zjctl" if OS.linux? && Hardware::CPU.arm?
    bin.install "zjctl" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
