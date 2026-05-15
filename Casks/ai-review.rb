cask "ai-review" do
  version "0.5.3"
  sha256 "9bebc92a04e86ab4b8f4296e8f0a0e8cba6d82a047384597bdbbe9714a2f4194"

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
