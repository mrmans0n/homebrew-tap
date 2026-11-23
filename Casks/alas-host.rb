cask "alas-host" do
  version "0.24.8"

  on_arm do
    sha256 "0f298b61e9383599d7d19b1b81e4cf93b15a9568edf4390973e2af6b261fc930"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "a4c2cca41b1c8fbc1af9b07bbed13718099e29380b1351d211b6661a55e50bbf"

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
