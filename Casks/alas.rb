cask "alas" do
  version "0.12.2"

  on_arm do
    sha256 "b17eeeebd3a533026f8bb1fb87345600ca3a9c7175c421c5e8f5ebdb7cd05c5b"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "2d53c6d2f42d204a13e9055dfb0e76e67c4e90a65670006424cf71218f99ab55"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-x86_64.dmg"
  end

  name "Alas"
  desc "AI parallel agent orchestrator"
  homepage "https://github.com/mrmans0n/alas"

  depends_on macos: :sonoma

  app "Alas.app"

  zap trash: [
    "~/Library/Application Support/Alas",
    "~/Library/Caches/io.nlopez.alas",
    "~/Library/HTTPStorages/io.nlopez.alas",
    "~/Library/Preferences/io.nlopez.alas.plist",
    "~/Library/Saved Application State/io.nlopez.alas.savedState",
    "~/Library/WebKit/io.nlopez.alas",
  ]
end
