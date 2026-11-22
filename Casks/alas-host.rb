cask "alas-host" do
  version "0.24.7"

  on_arm do
    sha256 "59b842b5accdf9cd88d25f98307f47ac34d34292e54f9c14ef94d05084f99ad5"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/alas-host-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "fa88a6a330bd81faa6c2f2d5a60ac8fc0f1bc096ddbb0e5abf3ea1ca9f3bace1"

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
