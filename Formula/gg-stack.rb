class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.6.0/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "442b1049c164996eb4b1930651b024d6c60aea7579202f53781e73890b8948c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.6.0/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "47b2d4f2e36bfd3aad549e0848d47f993ef10dc3dd594969db66af07ff5f0e81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.6.0/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a2dc3ba6c8309e27f46f53d37bd0a936f790614da91c6157eceebcd19174059"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.6.0/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b0923a3571c19e1d990c3417f3cb1913ea522b023caaca6433a692865cd22b1"
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
    bin.install "gg" if OS.mac? && Hardware::CPU.arm?
    bin.install "gg" if OS.mac? && Hardware::CPU.intel?
    bin.install "gg" if OS.linux? && Hardware::CPU.arm?
    bin.install "gg" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
