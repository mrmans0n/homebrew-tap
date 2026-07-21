class GgStack < Formula
  desc "CLI binary for git-gud (gg) stacked-diffs tool"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.10/gg-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8f0424d845fa357855faee986f28241b21afce7fc0d47fd87b4a826cbfb306a1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.10/gg-cli-x86_64-apple-darwin.tar.xz"
      sha256 "61181efebb5cb953082ccbc2895fd72c6aef5df4f9c77859baf36440764674e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.10/gg-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0408e455aceae49a5bd14f726830fd56bccd58d4381205b4040ada1f71dc6d83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.9.10/gg-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d0a1f3282fc9e1d5ae9541351e3ab4983e782a3092b8eee7b2676dd34bc842f"
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
