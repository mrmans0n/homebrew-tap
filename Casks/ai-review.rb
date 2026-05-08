cask "ai-review" do
  version "0.5.1"
  sha256 "203dc0011ecf1b2a1483ac28ef123feee5f966043bf39d258745efd61bb3e7eb"

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
