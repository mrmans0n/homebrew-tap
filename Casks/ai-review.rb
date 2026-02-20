cask "ai-review" do
  version "0.2.2"
  sha256 "d2e0420239e57bd6a26cd31dcdf911b8eb079e5b92fa9862ee79bce810d76da4"

  url "https://github.com/mrmans0n/ai-review/releases/download/v#{version}/AI.Review_#{version}_aarch64.dmg"
  name "AI Review"
  desc "Desktop code review tool for AI-generated diffs"
  homepage "https://github.com/mrmans0n/ai-review"

  depends_on arch: :arm64

  app "AI Review.app"
  binary "#{appdir}/AI Review.app/Contents/MacOS/AI Review", target: "air"

  zap trash: [
    "~/Library/Application Support/com.nacholopez.ai-review",
    "~/Library/Caches/com.nacholopez.ai-review",
  ]
end
