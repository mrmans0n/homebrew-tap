cask "alas" do
  version "0.24.4"

  on_arm do
    sha256 "a96f32e8a793b4e448dc9ebf542fb985341af8f665f2cd139010a44099375cb7"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "246d09fb8bca3634d177ae6f63b7192e235e489864a4c512e7a267c25d298777"

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
