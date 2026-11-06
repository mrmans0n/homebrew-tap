cask "alas" do
  version "0.23.3"

  on_arm do
    sha256 "bbceeddab5b2e16fe4fd56ad4d37ae2bc03006ffd2f8550712257a4a203f070e"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "b68ed339dbb2373de84f134b96fc0014111a58eb21b576d3d4dfc7127624b2a6"

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
