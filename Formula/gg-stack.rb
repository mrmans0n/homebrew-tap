class GgStack < Formula
  desc "A stacked-diffs CLI tool (gg) for GitHub and GitLab"
  homepage "https://github.com/mrmans0n/git-gud"
  url "https://github.com/mrmans0n/git-gud/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "bf5ce9bbae3565a7b8249bd9443882bd7312d6f15e35daec62ea3418d40a16b6"
  license "MIT"
  head "https://github.com/mrmans0n/git-gud.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gg --version")
  end
end
