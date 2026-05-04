cask "ai-review" do
  version "0.5.0"
  sha256 "af2f0d544c80d5c0a276fb7b64958439fc1a39019534aaca1342510d385ad81e"

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
