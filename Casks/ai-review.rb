cask "ai-review" do
  version "0.3.3"
  sha256 "f415d1b8b920cc7ab59c4eb5cba8ab2e5c7aca5b1cd3b19014e68f2d32f52a6a"

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
