cask "alas-host" do
  version "0.22.2"

  on_arm do
    sha256 "e6e2c702425c6d49d616a6fa72b38dd9da8f8d18468dcc640c923b1f1ab62270"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "fef36c8b0e09201e62128d8ebadc7636f9d82526fde04eacfc5a8b36cf842559"

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
