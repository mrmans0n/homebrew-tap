cask "alas" do
  version "0.2.0"
  sha256 "aba99113fb968194944c511765cd691951a409814cdc4192d4d4364727b19650"

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
