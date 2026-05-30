cask "alas" do
  version "0.4.8"

  on_arm do
    sha256 "2ceb54ed0deba355ce2e1a3e7507460f49560858340e161d2f6c4b3f9625d034"

    url "https://github.com/mrmans0n/alas/releases/download/v#{version}/Alas-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "f709c62b37ac6b4f74fee852807a017e3929c8a71f7678c9a926a92998180363"

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
