class GgStack < Formula
  desc "Stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.2/gg-stack-aarch64-apple-darwin.tar.xz"
      sha256 "5bc4abe1c3ba9274eaaf0645f20ba15bfb1f61a1272226ae7fe20df50d86db5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.2/gg-stack-x86_64-apple-darwin.tar.xz"
      sha256 "2e983d3cea49911b533b1e3ab05709c0c2fce9fc24fed88a6ecc04982990912d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.2/gg-stack-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fd5772e74c12fdea3e5bb1749bf55d46c026f51a3262552f04b9d8d5db7e80d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrmans0n/git-gud/releases/download/v0.3.2/gg-stack-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfadbcd9cf5662d6cd7599488332a499d8e139c7e5fb49de8f3bacafcc4c6e14"
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
