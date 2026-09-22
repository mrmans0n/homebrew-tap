class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1117b394c56521d24aeac42e524bc70c052c1aaeddc0d7f57e9748ab780d34bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0964597287d22c64f160ba9ea8b1d33089ba9d9b0f4f40a346fd221c79f683f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "150001796b58e047aeace1dc5e1e6f5e77076a08edd513edda0b87994fd688d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.10.3/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f59adba3a37d146db9aa1301be9713a75927a47ca6a2e76f5ab2d4a8df55f0c6"
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
end
