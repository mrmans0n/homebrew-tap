cask "alas-host" do
  version "0.23.4"

  on_arm do
    sha256 "7770d08fc83766d39425769c764a31becb4f335479dbbf82ec62222cb8959208"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "cfe1f747a9627e427ebdc3a3c5b66eb8102518851540e860d333d7b549e356a5"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-x86_64.zip"
  end

  name "Alas host"
  desc "Headless Alas host serving projects, sessions and runs"
  homepage "https://github.com/mrmans0n/alas"

  conflicts_with cask: "alas"
  depends_on macos: :sonoma

  binary "alas-host/alas-host"

  zap launchctl: ["io.nlopez.alas.host", "io.nlopez.alas.host.*"],
      trash:     "~/Library/LaunchAgents/io.nlopez.alas.host*.plist"
end
