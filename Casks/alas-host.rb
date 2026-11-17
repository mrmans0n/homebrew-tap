cask "alas-host" do
  version "0.24.1"

  on_arm do
    sha256 "b2c784638ecb6f8fbb55c41ebf8d0ed0e5236956bfbc4d8ffeeca045af0f5036"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "d1c6e869fb7e9f2c13534f2c85d6cadcf5b3cda1402f4a423ecdd68de6fb20b1"

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
