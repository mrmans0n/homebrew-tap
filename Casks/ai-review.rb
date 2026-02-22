cask "ai-review" do
  version "0.3.1"
  sha256 "7703efd1d3754586878ee4135ecb817c2997807abaa63321cfc0d015908eae9a"

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
