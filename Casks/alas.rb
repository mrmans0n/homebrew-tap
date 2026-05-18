cask "alas" do
  version "0.3.4"
  sha256 "e2a99e2181c3dc236c4b65a009d94b59b7d0f610971a1d3021569f4c193dc13c"

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
