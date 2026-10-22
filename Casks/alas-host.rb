cask "alas-host" do
  version "0.21.11"

  on_arm do
    sha256 "1ff817950cb61518a4990aac5e50f3cc3963bd942158fc2bd4230b024c8ed240"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "a676b56f318ffb85f42c2ffe23d82d7cce45bbdf956ebabb05e22f876f198e5a"

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
