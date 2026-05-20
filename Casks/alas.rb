cask "alas" do
  version "0.3.7"
  sha256 "a22b7d869ea7d83f7757bcb505ee6b5aa3fc3415211be0422e694282543dde70"

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
