cask "alas" do
  version "0.3.5"
  sha256 "861472559fb5367dc4a167f0b4c146a61a0ee798046d1f9abb029444e18e5d38"

  url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  name "Alas"
  desc "AI parallel agent orchestrator"
  homepage "https://github.com/mrmans0n/alas"

  depends_on arch: :arm64
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
