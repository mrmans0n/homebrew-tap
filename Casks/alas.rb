cask "alas" do
  version "0.24.8"

  on_arm do
    sha256 "10877b36c71ba902bb7738eaf9f7bba13746c43c22b355c894461ccea584e761"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "97e46ce890baf1cda4fb484ac348eda25a39722184ba372fc8d17f2312c284a0"

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
