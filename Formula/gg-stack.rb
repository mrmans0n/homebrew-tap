class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.5/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "868ac2cb05a822407774df9a0ea06d24e02059c26008c42a6a1ce52001d456dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.5/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "47e00252b0385082a427d951de68abb3516015a626d991377fdef76f693fb2ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.5/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2eaff524a9c173f657c3ca29afb290bd147fc7ba4153011e5f33ad7e35691bd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.5/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2faa9e78fd3e1798c8268050e8fcc72c043d91a08dad3f38f80e824fe5eba23"
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
      bin.install "gg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gg"
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
    assert_match version.to_s, shell_output("#{bin}/gg --version")
  end
end
