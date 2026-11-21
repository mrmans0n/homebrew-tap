cask "alas-host" do
  version "0.24.5"

  on_arm do
    sha256 "c94cb5d222a46d2a65ad3d2128e7321b1568ed2447fd0fffb2acd79d429700af"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "163f10924892cb2c5aebac477b16100935c8c52d23894016d44fbb150136d583"

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
