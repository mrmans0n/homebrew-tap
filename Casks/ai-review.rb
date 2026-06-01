cask "ai-review" do
  version "0.5.5"
  sha256 "bf7faa84b0b163d3010fcfa6a999be1149aa5527d695ffa50e38117bddcc5316"

  url "https://github.com/mrmans0n/ai-review/releases/download/v#{version}/AI.Review-#{version}-arm64.dmg"
  name "AI Review"
  desc "Desktop code review tool for AI-generated diffs"
  homepage "https://github.com/mrmans0n/ai-review"

  depends_on arch: :arm64

  app "AI Review.app"
  binary "#{appdir}/AI Review.app/Contents/MacOS/AI Review", target: "air"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/AI Review.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.nacholopez.ai-review",
    "~/Library/Caches/com.nacholopez.ai-review",
  ]
end
