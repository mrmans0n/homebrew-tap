cask "alas" do
  version "0.23.5"

  on_arm do
    sha256 "feed4e076584f319e2edc9235ff18d09114a940c05b37a0afce93e66078e1019"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "9e0010e9284e1ade7ef74a1644751ed99e466a2feef6766140616bbf6ae98879"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-x86_64.dmg"
  end

  name "Alas"
  desc "AI parallel agent orchestrator"
  homepage "https://github.com/mrmans0n/alas"

  conflicts_with cask: "alas-host"
  depends_on macos: :sonoma

  app "Alas.app"
  binary "#{appdir}/Alas.app/Contents/Resources/alas-host/alas-host"

  # The launchd agents `alas-host install-agent` installs, one per profile.
  # Not on uninstall, which an upgrade runs too: an agent survives upgrades,
  # and stops by itself once the app is gone (it runs while its executable
  # exists). The everyday profile's label is named as is: Homebrew's
  # wildcard matches only agents running at the time.
  zap launchctl: ["io.nlopez.alas.host", "io.nlopez.alas.host.*"],
      trash:     [
        "~/Library/Application Support/Alas",
        "~/Library/Caches/io.nlopez.alas",
        "~/Library/HTTPStorages/io.nlopez.alas",
        "~/Library/LaunchAgents/io.nlopez.alas.host*.plist",
        "~/Library/Preferences/io.nlopez.alas.plist",
        "~/Library/Saved Application State/io.nlopez.alas.savedState",
        "~/Library/WebKit/io.nlopez.alas",
      ]
end
